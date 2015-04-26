'use strict'

gulp        = require 'gulp'
$           = require('gulp-load-plugins')()
wiredep     = require('wiredep').stream
runSequence = require 'run-sequence'

gulp.task 'webpack', ->
  gulp.src './client/coffee/main.coffee'
    .pipe $.webpack require './webpack.config.coffee'
    .pipe gulp.dest './client/js'

gulp.task 'wiredep', ->
  gulp.src 'client/stylus/main.styl'
    .pipe wiredep()
    .pipe gulp.dest 'client/stylus'

gulp.task 'nodemon', ->
  $.nodemon
    script: 'server.coffee'

gulp.task 'watch', ->
  $.livereload.listen()
  gulp
    .watch [
      'client/views/**/*.jade'
      'client/js/bundle.js'
    ]
    .on 'change', $.livereload.changed

gulp.task 'default', ->
  runSequence 'nodemon', 'watch', 'webpack'
