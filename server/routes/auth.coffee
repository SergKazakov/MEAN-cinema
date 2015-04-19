jwt     = require 'jwt-simple'
express = require 'express'
moment  = require 'moment'
router  = express.Router()
User    = require '../models/user'
conf    = require '../config/config'

createToken = (user) ->
  payload =
    sub: user._id
    iat: moment().unix()
    exp: moment().add(14, 'days').unix()
  jwt.encode payload, conf.tokenSecret

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

module.exports = (app) -> app.use '/auth', router
