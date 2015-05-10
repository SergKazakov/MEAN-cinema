jwt        = require 'jwt-simple'
qs         = require 'querystring'
express    = require 'express'
router     = express.Router()
User       = require '../../models/user'
conf       = require '../../config/config'
request    = require 'request'
createJWT  = require './createJWT'

router
  .get '/twitter', (req, res, next) ->
    requestTokenUrl = 'https://api.twitter.com/oauth/request_token'
    accessTokenUrl  = 'https://api.twitter.com/oauth/access_token'
    authenticateUrl = 'https://api.twitter.com/oauth/authenticate'

    if not req.query.oauth_token or not req.query.oauth_verifier
      requestTokenOauth =
        consumer_key : conf.twitterKey
        consumer_secret : conf.twitterSecret
        callback : conf.twitterCallback

      request.post
        url : requestTokenUrl
        oauth : requestTokenOauth
      , (err, response, body) ->
        return next() if err
        oauthToken = qs.parse body
        params = qs.stringify oauth_token : oauthToken.oauth_token

        res.redirect "#{authenticateUrl}?#{params}"
    else
      accessTokenOauth =
        consumer_key : conf.twitterKey
        consumer_secret : conf.twitterSecret
        token : req.query.oauth_token
        verifier : req.query.oauth_verifier

      request.post
        url : accessTokenUrl
        oauth : accessTokenOauth
      , (err, response, profile) ->
        return next() if err
        profile = qs.parse profile
        if req.headers.authorization
          User.findOne twitter : profile.user_id, (err, existingUser) ->
            return next() if err
            return res.status(409).send message : 'There is already a Twitter account that belongs to you' if existingUser
            token = req.headers.authorization.split(' ')[1]
            payload = jwt.decode token, conf.tokenSecret
            User.findById payload.sub, (err, user) ->
              return res.status(400).send message : 'User not found' if not user
              user.twitter = profile.user_id
              user.displayName = user.displayName or profile.screen_name
              user.save (err) ->
                return next() if err
                res.send
                  user : user
                  token : createJWT user
        else
          User.findOne twitter : profile.user_id, (err, existingUser) ->
            return next() if err
            if existingUser
              return res.send
                user : existingUser
                token : createJWT existingUser
            user = new User
              twitter : profile.user_id
              displayName : profile.screen_name
            user.save (err) ->
              return next() if err
              res.send
                user : user
                token : createJWT user

module.exports = (app) -> app.use '/auth', router
