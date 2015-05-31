angular = require 'angular'
require 'normalize.css'
require 'stylus/main.styl'
require 'satellizer'
require 'angular-storage'
require 'ng-file-upload'
require 'bower/angular-loading-bar/build/loading-bar.min'
require 'bower/angular-strap/dist/angular-strap'
require 'bower/angular-strap/dist/angular-strap.tpl'
require 'bower/angular-permission/dist/angular-permission'
require 'bower/angular-utils-pagination/dirPagination'
require 'bower/ng-elif/src/elif'
require 'bower/angular-ui-select/dist/select.min'

angular
  .element document
  .ready ->
    angular
      .module 'cinema', require './main.requires'
      .config require './main.config'
      .run require './main.run'
    angular.bootstrap document, ['cinema'], strictDi : on
