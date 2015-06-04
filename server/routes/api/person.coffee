express    = require 'express'
router     = express.Router()
_          = require 'lodash'
mongoose   = require 'mongoose'
async      = require 'async'
Person     = mongoose.model 'Person'
Movie      = mongoose.model 'Movie'

createPerson = (person, req) ->
  newPerson       = if req.files.file? then JSON.parse req.body.person else req.body
  newPerson.photo = "img/media/#{req.files.file.name}" if req.files.file?
  _.assign person, newPerson

router
  .route '/persons'
  .get (req, res, next) ->
    if req.query.name
      criterion = name : new RegExp req.query.name, 'i'
    else criterion = {}
    if req.query.page
      Person.paginate {}, req.query.page, 10, (err, pageCount, paginatedResults, itemCount) ->
        return next(err) if err
        res.status(200).send
          items : paginatedResults
          count : itemCount
      ,
        sortBy : name : 1
    else
      Person.find criterion, (err, persons) ->
        return next(err) if err
        res.status(200).send persons
  .post (req, res, next) ->
    createPerson new Person(), req
      .save (err, person) ->
        return next(err) if err
        res.status(200).send person

router
  .route '/persons/:personId'
  .get (req, res, next) ->
    Person
      .findById req.params.personId
      .lean()
      .exec (err, person) ->
        return next(err) if err
        async.parallel [
          (cb) ->
            Movie.find actors : person._id, (err, movies) ->
              return next(err) if err
              cb null, movies
          (cb) ->
            Movie.find directors : person._id, (err, movies) ->
              return next(err) if err
              cb null, movies
        ], (err, results) ->
          return next(err) if err
          person.moviesAsActor = results[0]
          person.moviesAsDirector = results[1]
          res.status(200).send person
  .put (req, res, next) ->
    Person.findById req.params.personId, (err, person) ->
      return next(err) if err
      createPerson person, req
        .save (err, person) ->
          return next(err) if err
          res.status(200).send person
  .delete (req, res, next) ->
    Person.findByIdAndRemove req.params.personId, (err, person) ->
      return next(err) if err
      res.status(200).send person

module.exports = (app) -> app.use '/api/v1/', router
