express             = require 'express'
router              = express.Router()
User                = require '../../models/user'
createToken         = require './createToken'
ensureAuthenticated = require './ensureAuthenticated'

router
  .post '/login', (req, res) ->
    User.findOne email: req.body.email , '+password', (err, user) ->
      return res.status(401).send message: 'Wrong email and/or password' if not user
      user.comparePassword req.body.password, (err, isMatch) ->
        return res.status(401).send message: 'Wrong email and/or password' if not isMatch
        res.send token: createToken user

  .post '/signup', (req, res) ->
    User.findOne  email: req.body.email, (err, existingUser) ->
      return res.status(409).send message: 'Email is already taken' if existingUser
      user = new User
        displayName: req.body.displayName
        email: req.body.email
        password: req.body.password
      user.save ->
        res.send token: createToken user

  .get '/unlink/:provider', ensureAuthenticated, (req, res) ->
    provider = req.params.provider
    User.findById req.user, (err, user) ->
      return res.status(400).send message: 'User not found' if not user
      user[provider] = undefined
      user.save -> res.sendStatus 200

module.exports = (app) -> app.use '/auth', router
