express    = require 'express'
router     = express.Router()
mongoose   = require 'mongoose'
_          = require 'lodash'
Hall       = mongoose.model 'Hall'
Cinema     = mongoose.model 'Cinema'

router
  .route '/halls'
  .get (req, res, next) ->
    if req.query.page
      Hall.paginate {}, req.query.page, 10, (err, pageCount, paginatedResults, itemCount) ->
        return next(err) if err
        res.status(200).send
          items : paginatedResults
          count : itemCount
      ,
        sortBy : createdAt : -1
        populate : 'cinema'
    else
      Hall.find {}, (err, halls) ->
        return next(err) if err
        res.status(200).send halls
  .post (req, res, next) ->
    hall = new Hall req.body
    hall.save (err, hall) ->
      return next(err) if err
      Cinema.findOneAndUpdate
        _id : hall.cinema
      ,
        $addToSet :
          halls : hall._id
        upsert : on,
        (err, cinema) ->
          return next(err) if err
          res.status(200).send hall

router
  .route '/halls/:hallId'
  .get (req, res, next) ->
    Hall
      .findById req.params.hallId
      .populate 'cinema'
      .exec (err, hall) ->
        return next(err) if err
        res.status(200).send hall
  .put (req, res, next) ->
    Hall.findById req.params.hallId, (err, hall) ->
      return next(err) if err
      _.assign hall, req.body
      hall.save (err, hall) ->
        return next(err) if err
        Cinema.findOneAndUpdate
          _id : hall.cinema
        ,
          $addToSet :
            halls : hall._id
          upsert : on,
          (err, cinema) ->
            return next(err) if err
            res.status(200).send hall
  .delete (req, res, next) ->
    Hall.findByIdAndRemove req.params.hallId, (err, hall) ->
      return next(err) if err
      res.status(200).send hall

module.exports = (app) -> app.use '/api/v1/', router
