module.exports = (app) ->
  app.get '/', (req, res) -> res.sendFile require('path').join __dirname, 'client/index.html'
