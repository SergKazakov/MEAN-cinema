express    = require 'express'
router     = express.Router()
mongoose   = require 'mongoose'
async      = require 'async'
Person     = alias.require '@models/person'
Movie      = alias.require '@models/movie'

fillPerson = (person, newPerson, fileName) ->
  person.name       = newPerson.name
  person.career     = newPerson.career
  person.birthdate  = newPerson.birthdate
  person.birthPlace = newPerson.birthPlace
  person.gender     = newPerson.gender
  person.photo      = "img/media/#{fileName}" if fileName?
  person

router
  .route '/persons'
  .get (req, res, next) ->
    if req.query.name
      criterion = name : new RegExp req.query.name, 'i'
    else criterion = {}
    if req.query.page
      Person.paginate {}, req.query.page, 10, (err, pageCount, paginatedResults, itemCount) ->
        return next() if err
        res.status(200).send
          items : paginatedResults
          count : itemCount
      ,
        sortBy : name : 1
    else
      Person.find criterion, (err, persons) ->
        return next() if err
        res.status(200).send persons
  .post (req, res, next) ->
    newPerson = JSON.parse req.body.person
    fileName  = req.files.file.name
    fillPerson new Person(), newPerson, fileName
      .save (err, person) ->
        return next() if err
        res.status(200).send person

router
  .route '/person/:personId'
  .get (req, res, next) ->
    Person
      .findById req.params.personId
      .lean()
      .exec (err, person) ->
        return next() if err
        async.parallel [
          (cb) ->
            Movie.find actors : person._id, (err, movies) ->
              return next() if err
              cb null, movies
          (cb) ->
            Movie.find directors : person._id, (err, movies) ->
              return next() if err
              cb null, movies
        ], (err, results) ->
          return next() if err
          person.moviesAsActor = results[0]
          person.moviesAsDirector = results[1]
          res.status(200).send person
  .put (req, res, next) ->
    Person.findById req.params.personId, (err, person) ->
      return next() if err
      newPerson = if req.files.file? then JSON.parse req.body.person else req.body
      fileName  = if req.files.file? then req.files.file.name else null
      fillPerson person, newPerson, fileName
        .save (err, person) ->
          return next() if err
          res.status(200).send person
  .delete (req, res, next) ->
    Person.findByIdAndRemove req.params.personId, (err, person) ->
      return next() if err
      res.status(200).send person

module.exports = (app) -> app.use '/api/v1/', router
