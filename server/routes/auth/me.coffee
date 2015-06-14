express             = require 'express'
router              = express.Router()
_                   = require 'lodash'
User                = require('mongoose').model 'User'
createJWT           = require './createJWT'
ensureAuthenticated = require './ensureAuthenticated'

router
  .route '/me'
  .get ensureAuthenticated, (req, res, next) ->
    User.findById req.user, (err, user) ->
      return next(err) if err
      res.status(200).send user
  .put ensureAuthenticated, (req, res, next) ->
    User.findById req.user, (err, user) ->
      return next(err) if err
      return res.status(400).send message : 'User not found' if not user
      newUser         = if req.files.file? then JSON.parse req.body.user else req.body
      newUser.picture = "img/media/#{req.files.file.name}" if req.files.file?
      _.assign(user, newUser).save (err, user) ->
        return next(err) if err
        res.status(200).send token : createJWT user

module.exports = (app) -> app.use '/api/v1', router
