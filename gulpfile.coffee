'use strict'

gulp            = require 'gulp'
sass            = require 'gulp-sass'
autoprefixer    = require 'gulp-autoprefixer'
livereload      = require 'gulp-livereload'
sourcemaps      = require 'gulp-sourcemaps'
plumber         = require 'gulp-plumber'
coffee          = require 'gulp-coffee'
concat          = require 'gulp-concat'
nodemon         = require 'gulp-nodemon'
wiredep         = require('wiredep').stream

gulp.task 'sass', ->
  gulp.src 'client/scss/main.scss'
    .pipe plumber()
    .pipe sourcemaps.init()
    .pipe sass()
    .pipe autoprefixer
      browsers: [ 'last 2 versions' ]
      cascade: on
    .pipe sourcemaps.write()
    .pipe gulp.dest 'client/css'
    .pipe livereload()

gulp.task 'coffee', ->
  gulp.src([
    'client/coffee/main.coffee'
    'client/coffee/factory/**/*.coffee'
    'client/coffee/controller/**/*.coffee'
    ])
    .pipe plumber()
    .pipe coffee bare: on
    .pipe concat 'app.js'
    .pipe gulp.dest 'client/js'
    .pipe livereload()

gulp.task 'wiredep', ->
  gulp.src 'client/views/layout.jade'
    .pipe wiredep()
    .pipe gulp.dest 'client/views'

gulp.task 'nodemon', ->
  nodemon
    script: 'server.coffee'


gulp.task 'watch', [ 'sass', 'coffee' ], ->
  livereload.listen()
  gulp.watch 'client/scss/**/*.scss', [ 'sass' ]
  gulp.watch ['client/coffee/main.coffee', 'client/coffee/**/*.coffee'], [ 'coffee' ]

gulp.task 'default', ['nodemon', 'watch']
