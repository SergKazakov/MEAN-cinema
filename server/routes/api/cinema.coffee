express             = require 'express'
router              = express.Router()
_                   = require 'lodash'
moment              = require 'moment'
async               = require 'async'
mongoose            = require 'mongoose'
Cinema              = mongoose.model 'Cinema'
Review              = mongoose.model 'Review'
Session             = mongoose.model 'Session'
ensureAuthenticated = alias.require '@auth/ensureAuthenticated'
isAdmin             = alias.require '@auth/isAdmin'

createCinema = (cinema, req) ->
  newCinema         = if req.files.file? then JSON.parse req.body.cinema else req.body
  newCinema.poster  = "img/media/#{req.files.file.name}" if req.files.file?
  _.assign cinema, newCinema

router
  .route '/cinemas'
  .get (req, res, next) ->
    criterion = {}
    if req.query.page
      Cinema.paginate criterion
      ,
        page : req.query.page
        limit : req.query.size or 0
        populate : 'halls'
        sortBy : name : 1
      ,
        (err, results, pageCount, itemCount) ->
          return next(err) if err
          res.status(200).send
            items : results
            count : itemCount
    else
      criterion = name : new RegExp req.query.name, 'i' if req.query.name
      Cinema
        .find criterion
        .populate 'halls'
        .exec (err, cinemas) ->
          return next(err) if err
          res.status(200).send cinemas
  .post ensureAuthenticated, isAdmin, (req, res, next) ->
    createCinema new Cinema(), req
      .save (err, cinema) ->
        return next(err) if err
        res.status(200).send cinema

router
  .route '/cinemas/:cinemaId'
  .get (req, res, next) ->
    Cinema
      .findById req.params.cinemaId
      .deepPopulate 'halls reviews reviews.creator'
      .exec (err, cinema) ->
        return next(err) if err
        res.status(200).send cinema
  .put ensureAuthenticated, isAdmin, (req, res, next) ->
    Cinema.findById req.params.cinemaId, (err, cinema) ->
      return next(err) if err
      createCinema cinema, req
        .save (err, cinema) ->
          return next(err) if err
          res.status(200).send cinema
  .delete ensureAuthenticated, isAdmin, (req, res, next) ->
    Cinema.findByIdAndRemove req.params.cinemaId, (err, cinema) ->
      return next(err) if err
      res.status(200).send cinema

router
  .route '/cinemas/:cinemaId/reviews'
  .get (req, res, next) ->
    Cinema.findById req.params.cinemaId, (err, cinema) ->
      return next(err) if err
      criterion = _id : $in : cinema.reviews
      if req.query.page
        Review.paginate criterion
        ,
          page : req.query.page
          limit : req.query.size or 0
          populate : 'creator'
          sortBy : createdAt : -1
        ,
          (err, results, pageCount, itemCount) ->
            return next(err) if err
            res.status(200).send
              items : results
              count : itemCount
      else
        Review
          .find criterion
          .populate 'creator'
          .exec (err, reviews) ->
            return next(err) if err
            res.status(200).send reviews
  .post ensureAuthenticated, (req, res, next) ->
    async.waterfall [
      (cb) ->
        review = new Review()
        _.assign(review, req.body).creator = req.user._id
        review.save (err, review) ->
          return next(err) if err
          cb null, review
      (review, cb) ->
        Cinema.findByIdAndUpdate req.params.cinemaId
        ,
          $addToSet :
            reviews : review._id
        ,
          new : on
        ,
          (err, cinema) ->
            return next(err) if err
            cb null, cinema, review
      (cinema, review, cb) ->
        Review
          .findById review._id
          .populate 'creator'
          .exec (err, review) ->
            return next(err) if err
            cb null, review
    ], (err, result) ->
      return next(err) if err
      res.status(200).send result

router
  .route '/cinemas/:cinemaId/reviews/:reviewId'
  .delete ensureAuthenticated, isAdmin, (req, res, next) ->
    async.parallel [
      (cb) ->
        Cinema.findByIdAndUpdate req.params.cinemaId
        ,
          $pull :
            reviews : req.params.reviewId
        ,
          new : on
        ,
          (err, cinema) ->
            return next(err) if err
            cb null, cinema
      (cb) ->
        Review.findByIdAndRemove req.params.reviewId, (err, review) ->
          return next(err) if err
          cb null, review
    ], (err, results) ->
      return next(err) if err
      res.sendStatus 200

router
  .route '/cinemas/:cinemaId/sessions'
  .get (req, res, next) ->
    now = req.query.date or moment()
    midnight = moment().hours(23).minutes(59).seconds(59)
    Session
      .find cinema : req.params.cinemaId
      .where('date').gte(now).lte(midnight)
      .populate 'hall movie cinema'
      .exec (err, sessions) ->
        return next(err) if err
        res.status(200).send sessions

module.exports = (app) -> app.use '/api/v1/', router
