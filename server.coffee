'use strict'

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
  .set 'views', path.join __dirname, '/client/views'
  .set 'view engine', 'jade'
  .use morgan 'dev'
  .use bodyParser.json()
  .use bodyParser.urlencoded extended: on
  .use methodOverride()
  .use express.static path.join __dirname, 'client'

# Force HTTPS on Heroku
if app.get 'env' is 'production'
  app.use (req, res, next) ->
    protocol = req.get 'x-forwarded-proto'
    if protocol is 'https' then next() else res.redirect "https://#{req.hostname}#{req.url}"

require('./server/routes/auth/me') app
require('./server/routes/auth/simpleAuth') app
require('./server/routes/auth/google') app
require('./server/routes/auth/facebook') app
require('./server/routes/auth/twitter') app
require('./server/routes/auth/github') app
require('./server/routes/routes') app
require('./server/routes/error') app

app.listen process.env.PORT or conf.port
