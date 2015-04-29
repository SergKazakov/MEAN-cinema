jwt          = require 'jwt-simple'
express      = require 'express'
router       = express.Router()
User         = require '../../models/user'
conf         = require '../../config/config'
request      = require 'request'
createToken  = require './createToken'

router
  .post '/facebook', (req, res) ->
    accessTokenUrl = 'https://graph.facebook.com/v2.3/oauth/access_token'
    graphApiUrl = 'https://graph.facebook.com/v2.3/me'
    params =
      code: req.body.code
      client_id: req.body.clientId
      client_secret: conf.facebookSecret
      redirect_uri: req.body.redirectUri

    request.get
      url: accessTokenUrl
      qs: params
      json: on
    , (err, response, accessToken) ->
      return res.status(500).send message: accessToken.error.message if response.statusCode is not 200

      request.get
        url: graphApiUrl
        qs: accessToken
        json: on
      , (err, response, profile) ->
        return res.status(500).send message: profile.error.message if response.statusCode is not 200
        if req.headers.authorization
          User.findOne facebook: profile.id, (err, existingUser) ->
            return res.status(409).send message: 'There is already a Facebook account that belongs to you' if existingUser
            token = req.headers.authorization.split(' ')[1]
            payload = jwt.decode token, conf.tokenSecret
            User.findById payload.sub, (err, user) ->
              return res.status(400).send message: 'User not found' if not user
              user.facebook = profile.id
              user.picture = user.picture or "https://graph.facebook.com/v2.3/#{profile.id}/picture?type=large"
              user.displayName = user.displayName or profile.name
              user.save -> res.send token: createToken user
        else
          User.findOne facebook: profile.id, (err, existingUser) ->
            return res.send token: createToken existingUser if existingUser
            user = new User()
            user.facebook = profile.id
            user.picture = "https://graph.facebook.com/#{profile.id}/picture?type=large"
            user.displayName = profile.name
            user.save -> res.send token: createToken user

module.exports = (app) -> app.use '/auth', router