express             = require 'express'
router              = express.Router()
User                = require '../../models/user'
ensureAuthenticated = require './ensureAuthenticated'

router
  .route '/me'
  .get ensureAuthenticated, (req, res, next) ->
    User.findById req.user, (err, user) ->
      return next() if err
      res.status(200).send user
  .put ensureAuthenticated, (req, res, next) ->
    User.findById req.user, (err, user) ->
      return next() if err
      return res.status(400).send message : 'User not found' if not user
      user.displayName = req.body.displayName or user.displayName
      user.email = req.body.email or user.email
      user.save (err, user) ->
        return next() if err
        res.status(200).send user

module.exports = (app) -> app.use '/api/v1', router
