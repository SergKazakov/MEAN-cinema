express             = require 'express'
router              = express.Router()
User                = require('mongoose').model 'User'
ensureAuthenticated = require './ensureAuthenticated'

router
  .get '/unlink/:provider', ensureAuthenticated, (req, res, next) ->
    provider = req.params.provider
    User.findById req.user, (err, user) ->
      return next(err) if err
      return res.status(400).send message : 'User not found' if not user
      user[provider] = undefined
      user.save (err) ->
        return next(err) if err
        res.sendStatus 200

module.exports = (app) -> app.use '/auth', router
