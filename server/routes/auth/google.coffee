jwt          = require 'jwt-simple'
express      = require 'express'
router       = express.Router()
User         = require '../../models/user'
conf         = require '../../config/config'
request      = require 'request'
createToken  = require './createToken'

router
  .post '/google', (req, res) ->
    accessTokenUrl = 'https://accounts.google.com/o/oauth2/token'
    peopleApiUrl = 'https://www.googleapis.com/plus/v1/people/me/openIdConnect'
    params =
      code: req.body.code,
      client_id: req.body.clientId,
      client_secret: conf.googleSecret,
      redirect_uri: req.body.redirectUri,
      grant_type: 'authorization_code'

    request.post accessTokenUrl,
      json: on
      form: params
    , (err, response, token) ->
      accessToken = token.access_token
      headers = Authorization: "Bearer #{accessToken}"

      request.get
        url: peopleApiUrl
        headers: headers
        json: on
      , (err, response, profile) ->
        console.log profile
        if req.headers.authorization
          User.findOne google: profile.sub, (err, existingUser) ->
            return res.status(409).send message: 'There is already a Google account that belongs to you' if existingUser
            token = req.headers.authorization.split(' ')[1]
            payload = jwt.decode token, conf.tokenSecret
            User.findById payload.sub, (err, user) ->
              return res.status(400).send message: 'User not found' if not user
              user.google = profile.sub
              user.picture = user.picture or profile.picture.replace 'sz=50', 'sz=200'
              user.displayName = user.displayName or profile.name
              user.save -> res.send token: createToken user
        else
          User.findOne google: profile.sub, (err, existingUser) ->
            return res.send token: createToken existingUser if existingUser
            user = new User()
            user.google = profile.sub
            user.picture = profile.picture.replace 'sz=50', 'sz=200'
            user.displayName = profile.name
            user.save -> res.send token: createToken user

module.exports = (app) -> app.use '/auth', router
