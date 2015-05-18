express    = require 'express'
router     = express.Router()
mongoose   = require 'mongoose'
Cinema      = require '../../models/cinema'

fillCinema = (cinema, newCinema, fileName) ->
  cinema.name         = newCinema.name
  cinema.description  = newCinema.description
  cinema.address      = newCinema.address
  cinema.telephone    = newCinema.telephone
  cinema.website      = newCinema.website
  cinema.support3D    = newCinema.support3D
  cinema.poster       = "img/media/#{fileName}" if fileName?
  return cinema

router
  .route '/cinemas'
  .get (req, res, next) ->
    Cinema.find {}, (err, cinemas) ->
      return next() if err
      res.status(200).send cinemas
  .post (req, res, next) ->
    newCinema  = JSON.parse req.body.cinema
    fileName   = req.files.file.name
    fillCinema new Cinema(), newCinema, fileName
      .save (err, cinema) ->
        return next() if err
        res.status(200).send cinema

router
  .route '/cinema/:cinemaId'
  .get (req, res, next) ->
    Cinema
      .findById req.params.cinemaId, (err, cinema) ->
        return next() if err
        res.status(200).send cinema
  .put (req, res, next) ->
    Cinema.findById req.params.cinemaId, (err, cinema) ->
      return next() if err
      newCinema = if req.files.file? then JSON.parse req.body.cinema else req.body
      fileName  = if req.files.file? then req.files.file.name else null
      fillCinema cinema, newCinema, fileName
        .save (err, cinema) ->
          return next() if err
          res.status(200).send cinema
  .delete (req, res, next) ->
    Cinema.findByIdAndRemove req.params.cinemaId, (err, cinema) ->
      return next() if err
      res.status(200).send cinema

module.exports = (app) -> app.use '/api/v1/', router
