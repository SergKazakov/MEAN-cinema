jwt        = require 'jwt-simple'
qs         = require 'querystring'
express    = require 'express'
router     = express.Router()
User       = require('mongoose').model 'User'
conf       = alias.require '@config'
request    = require 'request'
createJWT  = require './createJWT'

router
  .post '/twitter', (req, res, next) ->
    requestTokenUrl = 'https://api.twitter.com/oauth/request_token'
    accessTokenUrl  = 'https://api.twitter.com/oauth/access_token'
    profileUrl      = 'https://api.twitter.com/1.1/users/show.json?screen_name='

    if not req.body.oauth_token or not req.body.oauth_verifier
      requestTokenOauth =
        consumer_key : conf.twitterKey
        consumer_secret : conf.twitterSecret
        callback : conf.twitterCallback

      request.post
        url : requestTokenUrl
        oauth : requestTokenOauth
      , (err, response, body) ->
        return next(err) if err
        oauthToken = qs.parse body
        res.send oauthToken
    else
      accessTokenOauth =
        consumer_key : conf.twitterKey
        consumer_secret : conf.twitterSecret
        token : req.body.oauth_token
        verifier : req.body.oauth_verifier

      request.post
        url : accessTokenUrl
        oauth : accessTokenOauth
      , (err, response, accessToken) ->
        return next(err) if err
        accessToken = qs.parse accessToken
        profileOauth =
          consumer_key : conf.twitterKey
          consumer_secret : conf.twitterSecret
          oauth_token : accessToken.oauth_token

        request.get
          url : "#{profileUrl}#{accessToken.screen_name}"
          oauth : profileOauth
          json : on
        , (err, response, profile) ->
          return next(err) if err
          if req.headers.authorization
            User.findOne twitter : profile.id, (err, existingUser) ->
              return next(err) if err
              if existingUser
                return res.status(409).send message : 'There is already a Twitter account that belongs to you'
              token = req.headers.authorization.split(' ')[1]
              payload = jwt.decode token, conf.tokenSecret
              User.findById payload.sub, (err, user) ->
                return next(err) if err
                unless user then return res.status(400).send message : 'User not found'
                user.twitter = profile.id
                user.displayName = user.displayName or profile.name
                user.picture = user.picture or profile.profile_image_url.replace '_normal', ''
                user.save (err) ->
                  return next(err) if err
                  res.send token : createJWT user
          else
            User.findOne twitter : profile.id, (err, existingUser) ->
              return next(err) if err
              return res.send token : createJWT existingUser if existingUser
              user = new User
                twitter : profile.id
                displayName : profile.name
                picture : profile.profile_image_url.replace '_normal', ''
              user.save (err) ->
                return next(err) if err
                res.send token : createJWT user

module.exports = (app) -> app.use '/auth', router
