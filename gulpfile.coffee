gulp         = require 'gulp'
$            = require('gulp-load-plugins')()
runSequence  = require 'run-sequence'
webpack      = require 'webpack-stream'
browserSync  = require 'browser-sync'
env          = process.env.NODE_ENV

conf =
  expressPort : 3000
  browserSyncPort : 7000

gulp.task 'webpack', ->
  gulp.src './client/coffee/main/main.coffee'
    .pipe webpack require('./webpack.config.coffee') production : env is 'production'
    .pipe gulp.dest './client/js'

gulp.task 'nodemon', ->
  $.nodemon
    ext : 'coffee'
    script : 'server/index.coffee'
    env :
      'NODE_ENV' : 'development'
      'PORT' : conf.expressPort
      'MONGO_URL' : 'mongodb://localhost/cinema'
      'TOKEN_SECRET' : 'A hard to guess string'
      'GOOGLE_SECRET' : '99sV-h9AJxgQS-Wj5UASECgU'
      'FACEBOOK_SECRET' : '4c999318d9cc99b18a404f554084e98b'
      'TWITTER_KEY' : 'vKhGVGsnCRHV5qKO3g0b8jTSa'
      'TWITTER_SECRET' : '9L0UdrluqoHDs8RorFrlL7P6Hv751iuEeJL3ke4AsVoTw861Ym'
      'TWITTER_CALLBACK' : "http://localhost:#{conf.browserSyncPort}"
      'GITHUB_SECRET' : '6038e35e20e6b4fc86e7a0694329eee7f8cf9814'

gulp.task 'server', ['nodemon'], ->
  browserSync.init
    proxy : "http://localhost:#{conf.expressPort}"
    files : ['client/js/bundle.js']
    port : conf.browserSyncPort
    open : no
  gulp.watch ['gulpfile.coffee', './server/**/*.coffee'], ['coffeelint']

gulp.task 'coffeelint', ->
  gulp.src './server/**/*.coffee'
    .pipe $.coffeelint()
    .pipe $.coffeelint.reporter()

gulp.task 'default', ->
  runSequence 'server', 'coffeelint', 'webpack'
