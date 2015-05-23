express    = require 'express'
router     = express.Router()
mongoose   = require 'mongoose'
Movie      = alias.require '@models/movie'

fillMovie = (movie, newMovie, fileName) ->
  movie.name        = newMovie.name
  movie.poster      = newMovie.poster
  movie.country     = newMovie.country
  movie.genre       = newMovie.genre
  movie.releaseDate = newMovie.releaseDate
  movie.synopsis    = newMovie.synopsis
  movie.duration    = parseInt newMovie.duration
  movie.ageRating   = parseInt newMovie.ageRating
  movie.status      = parseInt newMovie.status
  movie.actors      = newMovie.actors
  movie.poster      = "img/media/#{fileName}" if fileName?
  movie

router
  .route '/movies'
  .get (req, res, next) ->
    if req.query.status
      criterion = status : req.query.status
    else criterion = {}
    if req.query.page
      Movie.paginate {}, req.query.page, 10, (err, pageCount, paginatedResults, itemCount) ->
        return next() if err
        res.status(200).send
          items : paginatedResults
          count : itemCount
      ,
        sortBy : name : 1
    else
      Movie.find criterion, (err, movies) ->
        return next() if err
        res.status(200).send movies
  .post (req, res, next) ->
    newMovie  = JSON.parse req.body.movie
    fileName  = req.files.file.name
    fillMovie new Movie(), newMovie, fileName
      .save (err, movie) ->
        return next() if err
        res.status(200).send movie

router
  .route '/movie/:movieId'
  .get (req, res, next) ->
    Movie
      .findById req.params.movieId
      .populate 'actors'
      .exec (err, movie) ->
        return next() if err
        res.status(200).send movie
  .put (req, res, next) ->
    Movie.findById req.params.movieId, (err, movie) ->
      return next() if err
      newMovie  = if req.files.file? then JSON.parse req.body.movie else req.body
      fileName  = if req.files.file? then req.files.file.name else null
      fillMovie movie, newMovie, fileName
        .save (err, movie) ->
          return next() if err
          res.status(200).send movie
  .delete (req, res, next) ->
    Movie.findByIdAndRemove req.params.movieId, (err, movie) ->
      return next() if err
      res.status(200).send movie

module.exports = (app) -> app.use '/api/v1/', router
