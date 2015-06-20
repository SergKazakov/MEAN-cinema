express             = require 'express'
router              = express.Router()
mongoose            = require 'mongoose'
User                = mongoose.model 'User'
ensureAuthenticated = alias.require '@auth/ensureAuthenticated'
isAdmin             = alias.require '@auth/isAdmin'

router
  .route '/users'
  .get ensureAuthenticated, isAdmin, (req, res, next) ->
    criterion = {}
    if req.query.page
      User.paginate criterion, req.query.page, req.query.size or 0, (err, pageCount, paginatedResults, itemCount) ->
        return next(err) if err
        res.status(200).send
          items : paginatedResults
          count : itemCount
      ,
        sortBy : createdAt : 1
    else
      User.find criterion, (err, users) ->
        return next(err) if err
        res.status(200).send users

router
  .route '/users/:userId'
  .delete ensureAuthenticated, isAdmin, (req, res, next) ->
    User.findByIdAndRemove req.params.userId, (err, user) ->
      return next(err) if err
      res.status(200).send user

module.exports = (app) -> app.use '/api/v1/', router
