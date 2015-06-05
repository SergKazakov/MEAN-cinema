gulp         = require 'gulp'
$            = require('gulp-load-plugins')()
wiredep      = require('wiredep').stream
runSequence  = require 'run-sequence'
childProcess = require 'child_process'

gulp.task 'webpack', ->
  gulp.src './client/coffee/main/main.coffee'
    .pipe $.webpack require('./webpack.config.coffee') {}
    .pipe gulp.dest './client/js'

gulp.task 'wiredep', ->
  gulp.src 'client/stylus/main.styl'
    .pipe wiredep()
    .pipe gulp.dest 'client/stylus'

gulp.task 'nodemon', ->
  $.nodemon
    ext : 'coffee'
    script : 'server.coffee'
    env :
      'NODE_ENV' : 'development'
      'PORT' : 3000
      'MONGO_URL' : 'mongodb://localhost/cinema'
      'TOKEN_SECRET' : 'A hard to guess string'
      'GOOGLE_SECRET' : '99sV-h9AJxgQS-Wj5UASECgU'
      'FACEBOOK_SECRET' : '4c999318d9cc99b18a404f554084e98b'
      'TWITTER_KEY' : 'vKhGVGsnCRHV5qKO3g0b8jTSa'
      'TWITTER_SECRET' : '9L0UdrluqoHDs8RorFrlL7P6Hv751iuEeJL3ke4AsVoTw861Ym'
      'TWITTER_CALLBACK' : 'http://localhost:3000'
      'GITHUB_SECRET' : '6038e35e20e6b4fc86e7a0694329eee7f8cf9814'

gulp.task 'coffeelint', ->
  gulp.src [
      './*.coffee'
      './server/**/*.coffee'
      '!./client'
    ]
    .pipe $.coffeelint()
    .pipe $.coffeelint.reporter()

gulp.task 'watch', ->
  $.livereload.listen()
  gulp
    .watch [
      'client/js/bundle.js'
    ]
    .on 'change', $.livereload.changed
  gulp.watch ['./*.coffee', './server/**/*.coffee', '!./client'], ['coffeelint']

gulp.task 'clean', require('del').bind null, ['dist']

gulp.task 'webpack-production', ->
  gulp.src './client/coffee/main/main.coffee'
    .pipe $.webpack require('./webpack.config.coffee') production : on
    .pipe gulp.dest './client/js'

gulp.task 'copy', ->
  gulp.src [
    './client/img/**'
    './client/js/bundle.js'
    './client/index.html'
    './client/favicon.ico'
  ]
  , base : './client'
    .pipe gulp.dest './dist'

gulp.task 'build', ->
  runSequence ['webpack-production', 'clean'], 'copy'

gulp.task 'default', ->
  childProcess.exec '"C:/Program Files/MongoDB 2.6 Standard/bin/mongod.exe" --dbpath C:/mongodb' , (err, stdout, stderr) ->
    console.log stdout
  runSequence 'nodemon', 'coffeelint', 'watch', 'webpack'
