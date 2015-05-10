express = require 'express'
router  = express.Router()

router
  .get '/', (req, res) ->
    res.render 'partials/index'
  .get '/partials/:name', (req, res) ->
    res.render 'partials/' + req.params.name
  .get '*', (req, res) ->
    res.render 'partials/index'

module.exports = (app) ->  app.use '/', router
