require 'normalize.css'
require '../../stylus/main.styl'

angular = require 'angular'
require 'satellizer'
require 'angular-storage'
require '../../bower_components/angular-loading-bar/build/loading-bar.min.js'
require '../../bower_components/angular-strap/dist/angular-strap'
require '../../bower_components/angular-strap/dist/angular-strap.tpl'

angular
  .element document
  .ready ->
    angular
      .module 'cinema', require './main.requires'
      .config require './main.config'
      .run require './main.run'
    angular.bootstrap document, ['cinema']
