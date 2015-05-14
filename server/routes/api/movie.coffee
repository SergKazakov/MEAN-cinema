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
    movie = new Movie
      name : req.body.name
      poster : req.body.poster
      country : req.body.country
      genre : req.body.genre
      duration : parseInt req.body.duration
      ageRating : parseInt req.body.ageRating
      releaseDate : new Date req.body.releaseDate
      synopsis : req.body.synopsis
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
      movie.name        = req.body.name
      movie.poster      = req.body.poster
      movie.country     = req.body.country
      movie.genre       = req.body.genre
      movie.duration    = parseInt req.body.duration
      movie.ageRating   = parseInt req.body.ageRating
      movie.releaseDate = new Date req.body.releaseDate
      movie.synopsis    = req.body.synopsis
      movie.save (err, movie) ->
        return next() if err
        res.status(200).send movie
  .delete (req, res, next) ->
    Movie.findByIdAndRemove req.params.movieId, (err, movie) ->
      return next() if err
      res.status(200).send movie

module.exports = (app) -> app.use '/api/v1/', router
