jwt     = require 'jwt-simple'
moment  = require 'moment'
express = require 'express'
router  = express.Router()
User    = require '../models/user'
conf    = require '../config/config'

ensureAuthenticated = (req, res, next) ->
  if not req.headers.authorization
    return res
            .status 401
            .send message : 'Please make sure your request has an Authorization header'
  token = req.headers.authorization.split(' ')[1]
  payload = jwt.decode token, conf.tokenSecret
  if payload.exp <= moment().unix()
    return res.status(401).send message : 'Token has expired'
  req.user = payload.sub
  next()

router
  .get '/me', ensureAuthenticated, (req, res) ->
    User.findById req.user, (err, user) ->
      next() if err
      res.status(200).send user
  .put '/me', ensureAuthenticated, (req, res) ->
    User.findById req.user, (err, user) ->
      return res.status(400).send message: 'User not found' if not user
      user.displayName = req.body.displayName or user.displayName
      user.email = req.body.email or user.email
      user.save (err) ->
        next() if err
        res.sendStatus(200)

module.exports = (app) -> app.use '/api/v1', router
