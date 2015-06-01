express    = require 'express'
router     = express.Router()
mongoose   = require 'mongoose'
_          = require 'lodash'
moment     = require 'moment'
Session    = mongoose.model 'Session'
Cinema     = mongoose.model 'Cinema'

router
  .route '/sessions'
  .get (req, res, next) ->
    if req.query.page
      Session.paginate {}, req.query.page, 10, (err, pageCount, paginatedResults, itemCount) ->
        return next() if err
        res.status(200).send
          items : paginatedResults
          count : itemCount
      ,
        populate : 'movie hall cinema'
    else if req.query.cinema
      now = req.query.date or moment()
      midnight = moment().hours(23).minutes(59).seconds(59)
      Session
        .find {}
        .where('date').gte(now).lte(midnight)
        .populate 'hall movie cinema'
        .exec (err, sessions) ->
          return next(err) if err
          sessions = _.filter sessions, (item) -> item if item.cinema._id.toString() is req.query.cinema
          res.status(200).send sessions
    else if req.query.movie
      now = req.query.date or moment()
      midnight = moment().hours(23).minutes(59).seconds(59)
      Session
        .find movie : req.query.movie
        .where('date').gte(now).lte(midnight)
        .deepPopulate 'movie hall cinema.halls'
        .exec (err, sessions) ->
          return next(err) if err
          res.status(200).send sessions
    else
      Session
        .find {}
        .populate 'movie hall cinema'
        .exec (err, sessions) ->
          return next(err) if err
          res.status(200).send sessions
  .post (req, res, next) ->
    session = new Session req.body
    session.save (err, session) ->
      return next(err) if err
      res.status(200).send session

router
  .route '/session/:sessionId'
  .get (req, res, next) ->
    Session
      .findById req.params.sessionId
      .deepPopulate 'movie hall cinema cinema.halls'
      .exec (err, session) ->
        return next(err) if err
        res.status(200).send session
  .put (req, res, next) ->
    Session.findById req.params.sessionId, (err, session) ->
      return next(err) if err
      _.assign session, req.body
      session.save (err, session) ->
        return next(err) if err
        res.status(200).send session
  .delete (req, res, next) ->
    Session.findByIdAndRemove req.params.sessionId, (err, session) ->
      return next(err) if err
      res.status(200).send session

module.exports = (app) -> app.use '/api/v1/', router
