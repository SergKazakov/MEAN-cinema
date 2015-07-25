express             = require 'express'
router              = express.Router()
mongoose            = require 'mongoose'
_                   = require 'lodash'
Hall                = mongoose.model 'Hall'
Cinema              = mongoose.model 'Cinema'
ensureAuthenticated = alias.require '@auth/ensureAuthenticated'
isAdmin             = alias.require '@auth/isAdmin'

router
  .route '/halls'
  .get (req, res, next) ->
    criterion = {}
    if req.query.page
      Hall.paginate criterion
      ,
        page : req.query.page
        limit : req.query.size or 0
        populate : 'cinema'
        sortBy : createdAt : -1
      ,
        (err, results, pageCount, itemCount) ->
          return next(err) if err
          res.status(200).send
            items : results
            count : itemCount
    else
      Hall.find criterion, (err, halls) ->
        return next(err) if err
        res.status(200).send halls
  .post ensureAuthenticated, isAdmin, (req, res, next) ->
    hall = new Hall req.body
    hall.save (err, hall) ->
      return next(err) if err
      Cinema.findByIdAndUpdate hall.cinema
      ,
        $addToSet :
          halls : hall._id
      ,
        new : on
      ,
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
  .put ensureAuthenticated, isAdmin, (req, res, next) ->
    Hall.findById req.params.hallId, (err, hall) ->
      return next(err) if err
      _.assign hall, req.body
      hall.save (err, hall) ->
        return next(err) if err
        Cinema.findByIdAndUpdate hall.cinema
        ,
          $addToSet :
            halls : hall._id
        ,
          new : on
        ,
          (err, cinema) ->
            return next(err) if err
            res.status(200).send hall
  .delete ensureAuthenticated, isAdmin, (req, res, next) ->
    Hall.findByIdAndRemove req.params.hallId, (err, hall) ->
      return next(err) if err
      res.status(200).send hall

module.exports = (app) -> app.use '/api/v1/', router
