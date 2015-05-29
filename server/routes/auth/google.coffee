jwt        = require 'jwt-simple'
express    = require 'express'
router     = express.Router()
User       = require('mongoose').model 'User'
conf       = alias.require '@config'
request    = require 'request'
createJWT  = require './createJWT'

router
  .post '/google', (req, res, next) ->
    accessTokenUrl = 'https://accounts.google.com/o/oauth2/token'
    peopleApiUrl = 'https://www.googleapis.com/plus/v1/people/me/openIdConnect'
    params =
      code : req.body.code,
      client_id : req.body.clientId,
      client_secret : conf.googleSecret,
      redirect_uri : req.body.redirectUri,
      grant_type : 'authorization_code'

    request.post accessTokenUrl,
      json : on
      form : params
    , (err, response, token) ->
      return next() if err
      accessToken = token.access_token
      headers = Authorization : "Bearer #{accessToken}"

      request.get
        url : peopleApiUrl
        headers : headers
        json : on
      , (err, response, profile) ->
        return next() if err
        if req.headers.authorization
          User.findOne google : profile.sub, (err, existingUser) ->
            return res.status(409).send message : 'There is already a Google account that belongs to you' if existingUser
            token = req.headers.authorization.split(' ')[1]
            payload = jwt.decode token, conf.tokenSecret
            User.findById payload.sub, (err, user) ->
              return res.status(400).send message : 'User not found' if not user
              user.google = profile.sub
              user.picture = user.picture or profile.picture.replace 'sz=50', 'sz=200'
              user.displayName = user.displayName or profile.name
              user.save (err) ->
                return next() if err
                res.send
                  user : user
                  token : createJWT user
        else
          User.findOne google : profile.sub, (err, existingUser) ->
            return next() if err
            if existingUser
              return res.send
                user : existingUser
                token : createJWT existingUser
            user = new User
              google : profile.sub
              picture : profile.picture.replace 'sz=50', 'sz=200'
              displayName : profile.name
            user.save (err) ->
              return next() if err
              res.send
                user : user
                token : createJWT user

module.exports = (app) -> app.use '/auth', router
