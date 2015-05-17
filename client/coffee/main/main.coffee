angular = require 'angular'
require 'normalize.css'
require 'stylus/main.styl'
require 'satellizer'
require 'angular-storage'
require 'ng-file-upload'
require 'bower/angular-strap/dist/angular-strap'
require 'bower/angular-strap/dist/angular-strap.tpl'
require 'bower/ng-tags-input/ng-tags-input.min.js'
require 'bower/angular-block-ui/dist/angular-block-ui.min.js'

angular
  .element document
  .ready ->
    angular
      .module 'cinema', require './main.requires'
      .config require './main.config'
      .run require './main.run'
    angular.bootstrap document, ['cinema'], strictDi : on
