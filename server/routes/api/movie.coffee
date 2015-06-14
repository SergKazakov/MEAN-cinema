express    = require 'express'
router     = express.Router()
moment     = require 'moment'
_          = require 'lodash'
mongoose   = require 'mongoose'
Movie      = mongoose.model 'Movie'

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
      Movie.paginate {}, req.query.page, req.query.size or 0, (err, pageCount, paginatedResults, itemCount) ->
        return next(err) if err
        res.status(200).send
          items : paginatedResults
          count : itemCount
      ,
        sortBy : name : 1
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
  .post (req, res, next) ->
    createMovie new Movie(), req
      .save (err, movie) ->
        return next(err) if err
        res.status(200).send movie

router
  .route '/movies/:movieId'
  .get (req, res, next) ->
    Movie
      .findById req.params.movieId
      .populate 'directors actors'
      .exec (err, movie) ->
        return next(err) if err
        res.status(200).send movie
  .put (req, res, next) ->
    Movie.findById req.params.movieId, (err, movie) ->
      return next(err) if err
      createMovie movie, req
        .save (err, movie) ->
          return next(err) if err
          res.status(200).send movie
  .delete (req, res, next) ->
    Movie.findByIdAndRemove req.params.movieId, (err, movie) ->
      return next(err) if err
      res.status(200).send movie

module.exports = (app) -> app.use '/api/v1/', router
