express   = require 'express'
router    = express.Router()
User      = require('mongoose').model 'User'
createJWT = require './createJWT'

router
  .post '/login', (req, res, next) ->
    User.findOne email : req.body.email , '+password', (err, user) ->
      return next(err) if err
      return res.status(401).send message : 'Wrong email and/or password' if not user
      user.comparePassword req.body.password, (err, isMatch) ->
        return next(err) if (err)
        return res.status(401).send message : 'Wrong email and/or password' if not isMatch
        res.send token : createJWT user

  .post '/signup', (req, res, next) ->
    User.findOne  email : req.body.email, (err, existingUser) ->
      return next(err) if err
      return res.status(409).send message : 'Email is already taken' if existingUser
      user = new User
        displayName : req.body.displayName
        email : req.body.email
        password : req.body.password
      user.save (err, user) ->
        return next(err) if err
        res.send token : createJWT user

module.exports = (app) -> app.use '/auth', router
