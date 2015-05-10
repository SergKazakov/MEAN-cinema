module.exports = (app) ->
  if app.get 'env' is 'development'
    app.use (err, req, res, next) ->
      res.status err.status or 500
      res.render 'partials/error',
          message : err.message,
          error : err
  else
    app.use (err, req, res, next) ->
      res.status err.status or 500
      res.render 'partials/error',
          message : err.message
          error : {}
