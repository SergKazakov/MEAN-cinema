module.exports = (app) ->
  if app.get('env') is 'production'
    app.use (err, req, res, next) ->
      res
        .status(err.status or 500)
        .send
          message : err.message
          error : {}
  else
    app.use (err, req, res, next) ->
      res
        .status(err.status or 500)
        .send
          message : err.message
          error : err
