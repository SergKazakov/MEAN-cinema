'use strict'

express           = require 'express'
bodyParser        = require 'body-parser'
methodOverride    = require 'method-override'
morgan            = require 'morgan'
path              = require 'path'
mongoose          = require 'mongoose'
chalk             = require 'chalk'
http              = require 'http'
app               = module.exports = express()
server            = require('http').createServer(app);


app
  .set 'views', path.join __dirname, '/client/views'
  .set 'view engine', 'jade'
  .use morgan 'dev'
  .use bodyParser.json()
  .use bodyParser.urlencoded extended: false
  .use methodOverride()
  .use express.static path.join __dirname, 'client'

require('./server/routes/api') app
require('./server/routes/routes') app

server.listen process.env.PORT or 3000
