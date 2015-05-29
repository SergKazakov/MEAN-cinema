express    = require 'express'
router     = express.Router()
mongoose   = require 'mongoose'
_          = require 'lodash'
Session    = mongoose.model 'Session'

router
  .route '/sessions'
  .get (req, res, next) ->
    Session.find {}, (err, sessions) ->
      return next() if err
      res.status(200).send sessions
  .post (req, res, next) ->
    session = new Session req.body
    session.save (err, session) ->
      return next() if err
      res.status(200).send session

router
  .route '/session/:sessionId'
  .get (req, res, next) ->
    Session
      .findById req.params.sessionId
      .populate 'movie hall'
      .exec (err, session) ->
        return next() if err
        res.status(200).send session
  .put (req, res, next) ->
    Session.findById req.params.sessionId, (err, session) ->
      return next() if err
      _.assign session, req.body
      session.save (err, session) ->
        return next() if err
        res.status(200).send session
  .delete (req, res, next) ->
    Session.findByIdAndRemove req.params.sessionId, (err, session) ->
      return next() if err
      res.status(200).send session

module.exports = (app) -> app.use '/api/v1/', router
