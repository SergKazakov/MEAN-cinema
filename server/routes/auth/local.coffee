express             = require 'express'
router              = express.Router()
User                = require '../../models/user'
createToken         = require './createToken'
ensureAuthenticated = require './ensureAuthenticated'

router
  .post '/login', (req, res, next) ->
    User.findOne email: req.body.email , '+password', (err, user) ->
      next() if err
      return res.status(401).send message: 'Wrong email and/or password' if not user
      user.comparePassword req.body.password, (err, isMatch) ->
        next() if (err)
        return res.status(401).send message: 'Wrong email and/or password' if not isMatch
        res.send
          user : user
          token: createToken user

  .post '/signup', (req, res, next) ->
    User.findOne  email: req.body.email, (err, existingUser) ->
      next() if err
      return res.status(409).send message: 'Email is already taken' if existingUser
      user = new User
        displayName: req.body.displayName
        email: req.body.email
        password: req.body.password
      user.save (err, user) ->
        next() if err
        res.send
          user : user
          token: createToken user

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
