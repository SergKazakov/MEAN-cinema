express             = require 'express'
router              = express.Router()
mongoose            = require 'mongoose'
_                   = require 'lodash'
moment              = require 'moment'
Session             = mongoose.model 'Session'
Cinema              = mongoose.model 'Cinema'
ensureAuthenticated = alias.require '@auth/ensureAuthenticated'
isAdmin             = alias.require '@auth/isAdmin'

router
  .route '/sessions'
  .get (req, res, next) ->
    criterion = {}
    if req.query.page
      Session.paginate criterion
      ,
        page : req.query.page
        limit : req.query.size or 0
        populate : 'movie hall cinema'
      ,
        (err, results, pageCount, itemCount) ->
          return next(err) if err
          res.status(200).send
            items : results
            count : itemCount
    else
      Session
        .find criterion
        .populate 'movie hall cinema'
        .exec (err, sessions) ->
          return next(err) if err
          res.status(200).send sessions
  .post ensureAuthenticated, isAdmin, (req, res, next) ->
    session = new Session req.body
    session.save (err, session) ->
      return next(err) if err
      res.status(200).send session

router
  .route '/sessions/:sessionId'
  .get (req, res, next) ->
    Session
      .findById req.params.sessionId
      .deepPopulate 'movie hall cinema cinema.halls'
      .exec (err, session) ->
        return next(err) if err
        res.status(200).send session
  .put ensureAuthenticated, isAdmin, (req, res, next) ->
    Session.findById req.params.sessionId, (err, session) ->
      return next(err) if err
      _.assign session, req.body
      session.save (err, session) ->
        return next(err) if err
        res.status(200).send session
  .delete ensureAuthenticated, isAdmin, (req, res, next) ->
    Session.findByIdAndRemove req.params.sessionId, (err, session) ->
      return next(err) if err
      res.status(200).send session

module.exports = (app) -> app.use '/api/v1/', router
