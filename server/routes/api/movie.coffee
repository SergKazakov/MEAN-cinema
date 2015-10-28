express             = require 'express'
router              = express.Router()
moment              = require 'moment'
_                   = require 'lodash'
async               = require 'async'
mongoose            = require 'mongoose'
Movie               = mongoose.model 'Movie'
Review              = mongoose.model 'Review'
Session             = mongoose.model 'Session'
ensureAuthenticated = alias.require '@auth/ensureAuthenticated'
isAdmin             = alias.require '@auth/isAdmin'

createMovie = (movie, req) ->
  newMovie              = if req.files.file? then JSON.parse req.body.movie else req.body
  newMovie.releaseDate  = moment(newMovie.releaseDate).format('YYYY-MM-DD') if newMovie.releaseDate?
  newMovie.finishDate   = moment(newMovie.finishDate).format('YYYY-MM-DD')  if newMovie.finishDate?
  newMovie.poster       = "img/media/#{req.files.file.name}" if req.files.file?
  _.assign movie, newMovie

router
  .route '/movies'
  .get (req, res, next) ->
    criterion = {}
    if req.query.page
      Movie.paginate criterion
      ,
        page : req.query.page
        limit : req.query.size or 0
        sortBy : name : 1
      ,
        (err, results, pageCount, itemCount) ->
          return next(err) if err
          res.status(200).send
            items : results
            count : itemCount
    else
      if req.query.status
        if req.query.status is 'now'
          currentDate = moment().format('YYYY-MM-DD')
          criterion =
            releaseDate :
              $lte : currentDate
            finishDate :
              $gte : currentDate
        else if req.query.status is 'upcoming'
          nextThursday = moment().day('Thursday')
          now = moment()
          nextThursday = if now.diff(nextThursday) >= 0 then moment().day(11).format('YYYY-MM-DD') else nextThursday.format('YYYY-MM-DD')
          criterion = releaseDate : nextThursday
      else if req.query.name then criterion = name : new RegExp req.query.name, 'i'
      Movie.find criterion, (err, movies) ->
        return next(err) if err
        res.status(200).send movies
  .post ensureAuthenticated, isAdmin, (req, res, next) ->
    createMovie new Movie(), req
      .save (err, movie) ->
        return next(err) if err
        res.status(200).send movie

router
  .route '/movies/:movieId'
  .get (req, res, next) ->
    Movie
      .findById req.params.movieId
      .deepPopulate 'directors actors reviews reviews.creator'
      .exec()
      .then (movie) -> res.status(200).send movie
      .end (err) -> next(err) if err
  .put ensureAuthenticated, isAdmin, (req, res, next) ->
    Movie
      .findById(req.params.movieId)
      .exec()
      .then (movie) -> createMovie(movie, req).save()
      .then (movie) -> res.status(200).send movie
      .end (err) -> next(err) if err
  .delete ensureAuthenticated, isAdmin, (req, res, next) ->
    Movie.findByIdAndRemove req.params.movieId, (err, movie) ->
      return next(err) if err
      res.status(200).send movie

router
  .route '/movies/:movieId/reviews'
  .get (req, res, next) ->
    Movie.findById req.params.movieId, (err, movie) ->
      return next(err) if err
      criterion = _id : $in : movie.reviews
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
        Movie.findByIdAndUpdate req.params.movieId
        ,
          $addToSet :
            reviews : review._id
        ,
          new : on
        ,
          (err, movie) ->
            return next(err) if err
            cb null, movie, review
      (movie, review, cb) ->
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
  .route '/movies/:movieId/reviews/:reviewId'
  .delete ensureAuthenticated, isAdmin, (req, res, next) ->
    async.parallel [
      (cb) ->
        Movie.findByIdAndUpdate req.params.movieId
        ,
          $pull :
            reviews : req.params.reviewId
        ,
          new : on
        ,
          (err, movie) ->
            return next(err) if err
            cb null, movie
      (cb) ->
        Review.findByIdAndRemove req.params.reviewId, (err, review) ->
          return next(err) if err
          cb null, review
    ], (err, results) ->
      return next(err) if err
      res.sendStatus 200

router
  .route '/movies/:movieId/sessions'
  .get (req, res, next) ->
    now = req.query.date or moment()
    midnight = moment().hours(23).minutes(59).seconds(59)
    Session
      .find movie : req.params.movieId
      .where('date').gte(now).lte(midnight)
      .deepPopulate 'movie hall cinema.halls'
      .exec (err, sessions) ->
        return next(err) if err
        res.status(200).send sessions

module.exports = (app) -> app.use '/api/v1/', router
