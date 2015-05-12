express    = require 'express'
router     = express.Router()
mongoose   = require 'mongoose'
Person      = require '../../models/person'

router
  .route '/persons'
  .get (req, res, next) ->
    Person.find {}, (err, persons) ->
      return next() if err
      res.status(200).send persons
  .post (req, res, next) ->
    person = new Person req.body
    person.save (err, person) ->
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
      person.name = req.body.name
      person.photo = req.body.photo
      person.career = req.body.career
      person.birthdate = req.body.birthdate
      person.birthPlace = req.body.birthPlace
      person.save (err, person) ->
        return next() if err
        res.status(200).send person
  .delete (req, res, next) ->
    Person.findByIdAndRemove req.params.personId, (err, person) ->
      return next() if err
      res.status(200).send person

module.exports = (app) -> app.use '/api/v1/', router
