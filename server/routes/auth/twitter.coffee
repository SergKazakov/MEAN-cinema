jwt          = require 'jwt-simple'
qs           = require 'querystring'
express      = require 'express'
router       = express.Router()
User         = require '../../models/user'
conf         = require '../../config/config'
request      = require 'request'
createToken  = require './createToken'

router
  .get '/twitter', (req, res) ->
    requestTokenUrl = 'https://api.twitter.com/oauth/request_token'
    accessTokenUrl  = 'https://api.twitter.com/oauth/access_token'
    authenticateUrl = 'https://api.twitter.com/oauth/authenticate'

    if not req.query.oauth_token or not req.query.oauth_verifier
      requestTokenOauth =
        consumer_key: conf.twitterKey
        consumer_secret: conf.twitterSecret
        callback: conf.twitterCallback

      request.post
        url: requestTokenUrl
        oauth: requestTokenOauth
      , (err, response, body) ->
        oauthToken = qs.parse body
        params = qs.stringify oauth_token: oauthToken.oauth_token

        res.redirect "#{authenticateUrl}?#{params}"
    else
      accessTokenOauth =
        consumer_key: conf.twitterKey
        consumer_secret: conf.twitterSecret
        token: req.query.oauth_token
        verifier: req.query.oauth_verifier

      request.post
        url: accessTokenUrl
        oauth: accessTokenOauth
      , (err, response, profile) ->
        profile = qs.parse profile
        if req.headers.authorization
          User.findOne twitter: profile.user_id, (err, existingUser) ->
            return res.status(409).send message: 'There is already a Twitter account that belongs to you' if existingUser
            token = req.headers.authorization.split(' ')[1]
            payload = jwt.decode token, conf.tokenSecret
            User.findById payload.sub, (err, user) ->
              return res.status(400).send message: 'User not found' if not user
              user.twitter = profile.user_id
              user.displayName = user.displayName or profile.screen_name
              user.save (err) -> res.send token: createToken user
        else
          User.findOne twitter: profile.user_id, (err, existingUser) ->
            return res.send token: createToken existingUser if existingUser
            user = new User()
            user.twitter = profile.user_id
            user.displayName = profile.screen_name
            user.save -> res.send token: createToken user

module.exports = (app) -> app.use '/auth', router