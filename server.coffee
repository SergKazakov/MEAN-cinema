'use strict'

express           = require 'express'
bodyParser        = require 'body-parser'
methodOverride    = require 'method-override'
morgan            = require 'morgan'
path              = require 'path'
mongoose          = require 'mongoose'
chalk             = require 'chalk'
conf              = require 'nconf'
http              = require 'http'
app               = module.exports = express()
server            = require('http').createServer(app);

conf.argv()
    .env()
    .file
      file: path.join __dirname, 'server/config/config.json'

app
  .set 'views', path.join __dirname, '/client/views'
  .set 'view engine', 'jade'
  .use morgan 'dev'
  .use bodyParser.json()
  .use bodyParser.urlencoded extended: on
  .use methodOverride()
  .use express.static path.join __dirname, 'client'

require('./server/routes/api') app
require('./server/routes/routes') app

server.listen process.env.PORT or conf.get 'port'
