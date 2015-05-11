express    = require 'express'
router     = express.Router()
mongoose   = require 'mongoose'
Movie      = require '../../models/movie'

router
  .route '/movies'
  .get (req, res, next) ->
    Movie.find {}, (err, movies) ->
      return next() if err
      res.status(200).send movies
  .post (req, res, next) ->
    move = new Movie req.body.movie
    movie.save (err, movie) ->
      return next() if err
      res.status(200).send movie

router
  .route '/movie/:movieId'
  .get (req, res, next) ->
    Movie.findById req.params.movieId, (err, movie) ->
      return next() if err
      res.status(200).send movie
  .put (req, res, next) ->
    Movie.findById req.params.movieId, (err, movie) ->
      return next() if err
      movie = new Movie req.body.movie
      movie.save (err, movie) ->
        return next() if err
        res.status(200).send movie
  .delete (req, res, next) ->
    Movie.findByIdAndRemove mongoose.Types.ObjectId req.params.movieId, (err, movie) ->
      return next() if err
      res.status(200).send movie

module.exports = (app) -> app.use '/api/v1/', router
