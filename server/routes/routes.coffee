module.exports = (app) ->
  app.get '/', (req, res) -> res.sendfile 'index.html'
