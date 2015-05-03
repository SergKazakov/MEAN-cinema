express             = require 'express'
router              = express.Router()
User                = require '../../models/user'
ensureAuthenticated = require './ensureAuthenticated'

router
  .get '/unlink/:provider', ensureAuthenticated, (req, res, next) ->
    provider = req.params.provider
    User.findById req.user, (err, user) ->
      next() if err
      return res.status(400).send message: 'User not found' if not user
      user[provider] = undefined
      user.save (err) ->
        next() if err
        res.sendStatus 200

module.exports = (app) -> app.use '/auth', router
