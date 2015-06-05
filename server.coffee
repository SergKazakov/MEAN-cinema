express        = require 'express'
bodyParser     = require 'body-parser'
methodOverride = require 'method-override'
morgan         = require 'morgan'
path           = require 'path'
mongoose       = require 'mongoose'
multer         = require 'multer'
chalk          = require 'chalk'
Alias          = require 'require-alias'
app            = module.exports = express()

require('pretty-error').start()

global.alias = new Alias
  aliases :
    '@config' : './server/config'
    '@models' : './server/models'
    '@routes' : './server/routes'

conf = alias.require '@config'

mongoose.connect conf.mongoUrl
mongoose.connection.on 'error', (err) ->
  console.log chalk.bgRed.bold "MongoDB connection error: #{err}"

if app.get('env') is 'development' then staticPath = 'client' else staticPath = 'dist'

app
  .use morgan 'dev'
  .use bodyParser.json()
  .use bodyParser.urlencoded extended : on
  .use methodOverride()
  .set 'views', path.join __dirname, 'server/views'
  .engine 'html', require('ejs').renderFile
  .set 'view engine', 'html'
  .use express.static path.join __dirname, staticPath
  .use multer
    dest : "./#{staticPath}/img/media/"
    rename : (fieldname, filename) ->
      filename.replace(/\W+/g, '-').toLowerCase() + Date.now()

# Force HTTPS on Heroku
if app.get 'env' is 'production'
  app.use (req, res, next) ->
    protocol = req.get 'x-forwarded-proto'
    if protocol is 'https' then next() else res.redirect "https://#{req.hostname}#{req.url}"

alias.require('@routes') app

app.listen conf.port
