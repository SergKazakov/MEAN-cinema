jwt        = require 'jwt-simple'
qs         = require 'querystring'
express    = require 'express'
router     = express.Router()
User       = require('mongoose').model 'User'
conf       = alias.require '@config'
request    = require 'request'
createJWT  = require './createJWT'

router
  .post '/github', (req, res, next) ->
    accessTokenUrl = 'https://github.com/login/oauth/access_token'
    userApiUrl = 'https://api.github.com/user'
    params =
      code : req.body.code
      client_id : req.body.clientId
      client_secret : conf.githubSecret
      redirect_uri : req.body.redirectUri

    request.get
      url : accessTokenUrl
      qs : params
    , (err, response, accessToken) ->
      return next(err) if err
      accessToken = qs.parse accessToken
      headers = 'User-Agent' : 'Satellizer'

      request.get
        url : userApiUrl
        qs : accessToken
        headers : headers
        json : on
      , (err, response, profile) ->
        return next(err) if err
        if req.headers.authorization
          User.findOne github : profile.id, (err, existingUser) ->
            return res.status(409).send message : 'There is already a GitHub account that belongs to you' if existingUser
            token = req.headers.authorization.split(' ')[1]
            payload = jwt.decode token, conf.tokenSecret
            User.findById payload.sub, (err, user) ->
              return res.status(400).send message : 'User not found' if not user
              user.github = profile.id
              user.picture = user.picture or profile.avatar_url
              user.displayName = user.displayName or profile.name
              user.save (err) ->
                return next(err) if err
                res.send
                  user : user
                  token : createJWT user
        else
          User.findOne github : profile.id, (err, existingUser) ->
            return next(err) if err
            if existingUser
              return res.send
                user : existingUser
                token : createJWT existingUser
            user = new User
              github : profile.id
              picture : profile.avatar_url
              displayName : profile.name
            user.save (err) ->
              return next(err) if err
              res.send
                user : user
                token : createJWT user

module.exports = (app) -> app.use '/auth', router
