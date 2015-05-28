express    = require 'express'
router     = express.Router()
_          = require 'lodash'
mongoose   = require 'mongoose'
Cinema     = alias.require '@models/cinema'

createCinema = (cinema, req) ->
  newCinema         = if req.files.file? then JSON.parse req.body.cinema else req.body
  newCinema.poster  = "img/media/#{req.files.file.name}" if req.files.file?
  _.assign cinema, newCinema

router
  .route '/cinemas'
  .get (req, res, next) ->
    criterion = {}
    if req.query.page
      Cinema.paginate {}, req.query.page, 10, (err, pageCount, paginatedResults, itemCount) ->
        return next() if err
        res.status(200).send
          items : paginatedResults
          count : itemCount
      ,
        sortBy : name : 1
    else
      criterion = name : new RegExp req.query.name, 'i' if req.query.name
      Cinema.find criterion, (err, cinemas) ->
        return next() if err
        res.status(200).send cinemas
  .post (req, res, next) ->
    createCinema new Cinema(), req
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
      createCinema cinema, req
        .save (err, cinema) ->
          return next() if err
          res.status(200).send cinema
  .delete (req, res, next) ->
    Cinema.findByIdAndRemove req.params.cinemaId, (err, cinema) ->
      return next() if err
      res.status(200).send cinema

module.exports = (app) -> app.use '/api/v1/', router
