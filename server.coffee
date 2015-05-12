express        = require 'express'
bodyParser     = require 'body-parser'
methodOverride = require 'method-override'
morgan         = require 'morgan'
path           = require 'path'
mongoose       = require 'mongoose'
chalk          = require 'chalk'
conf           = require './server/config/config'
app            = module.exports = express()

mongoose.connect conf.mongoUrl
mongoose.connection.on 'error', (err) ->
  console.log chalk.bgRed.bold "MongoDB connection error: #{err}"
  process.exit -1

app
  .use morgan 'dev'
  .use bodyParser.json()
  .use bodyParser.urlencoded extended : on
  .use methodOverride()
  .set 'views', path.join __dirname, 'server/views'
  .engine 'html', require('ejs').renderFile
  .set 'view engine', 'html'
  .use express.static path.join __dirname, 'client'

# Force HTTPS on Heroku
if app.get 'env' is 'production'
  app.use (req, res, next) ->
    protocol = req.get 'x-forwarded-proto'
    if protocol is 'https' then next() else res.redirect "https://#{req.hostname}#{req.url}"

[
  'auth/me'
  'auth/local'
  'auth/google'
  'auth/facebook'
  'auth/twitter'
  'auth/github'
  'auth/unlink'
  'api/movie'
  'api/person'
  'error'
].map (path) -> require("./server/routes/#{path}") app

app.listen conf.port
