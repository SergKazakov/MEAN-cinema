'use strict'

gulp        = require 'gulp'
$           = require('gulp-load-plugins')()
wiredep     = require('wiredep').stream
runSequence = require 'run-sequence'

gulp.task 'stylus', ->
  gulp.src 'client/stylus/main.styl'
    .pipe $.plumber()
    .pipe $.sourcemaps.init()
    .pipe $.stylus 'include css': on
    .pipe $.autoprefixer
      browsers: [ 'last 2 versions' ]
      cascade: on
    .pipe $.sourcemaps.write()
    .pipe gulp.dest 'client/css'
    .pipe $.notify 'Stylus'
    .pipe $.livereload()

gulp.task 'coffee', ->
  gulp.src [
    'client/coffee/main.coffee'
    'client/coffee/directives/**/*.coffee'
    'client/coffee/factories/**/*.coffee'
    'client/coffee/controllers/**/*.coffee'
    ]
    .pipe $.plumber()
    .pipe $.coffee bare: on
    .pipe $.concat 'app.js'
    .pipe gulp.dest 'client/js'
    .pipe $.notify 'Coffee'
    .pipe $.livereload()

gulp.task 'coffee-lint', ->
  gulp.src 'client/coffee/**/*.coffee'
    .pipe $.coffeelint optFile: './coffeelint.json'
    .pipe $.coffeelint.reporter()

gulp.task 'wiredep', ->
  gulp.src 'client/views/layout.jade'
    .pipe wiredep()
    .pipe gulp.dest 'client/views'

  gulp.src 'client/stylus/main.styl'
    .pipe wiredep()
    .pipe gulp.dest 'client/stylus'

gulp.task 'nodemon', ->
  $.nodemon
    script: 'server.coffee'

gulp.task 'watch', ->
  $.livereload.listen()
  gulp.watch 'client/stylus/**/*.styl', [ 'stylus' ]
  gulp.watch ['client/coffee/**/*.coffee'], [ 'coffee' ]
  gulp
    .watch ['client/views/**/*.jade']
    .on 'change', $.livereload.changed

gulp.task 'default', ->
  runSequence ['stylus', 'coffee'], 'nodemon', 'watch'
