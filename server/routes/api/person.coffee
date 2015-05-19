express    = require 'express'
router     = express.Router()
mongoose   = require 'mongoose'
Person     = require '../../models/person'

fillPerson = (person, newPerson, fileName) ->
  person.name       = newPerson.name
  person.career     = newPerson.career
  person.birthdate  = newPerson.birthdate
  person.birthPlace = newPerson.birthPlace
  person.photo      = "img/media/#{fileName}" if fileName?
  return person

router
  .route '/persons'
  .get (req, res, next) ->
    if req.query.name
      reqex = new RegExp req.query.name, 'i'
      Person.find name : reqex, (err, actors) ->
        return next() if err
        res.status(200).send actors
    else
      Person.find {}, (err, persons) ->
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
    Person.findById req.params.personId, (err, person) ->
      return next() if err
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
