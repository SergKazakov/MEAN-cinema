express             = require 'express'
router              = express.Router()
User                = require '../../models/user'
ensureAuthenticated = require './ensureAuthenticated'

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
