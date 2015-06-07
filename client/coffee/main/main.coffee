angular = require 'angular'

require 'satellizer'
require 'ng-file-upload'

require 'bower/angular-loading-bar/build/loading-bar.min'
require 'bower/angular-strap/dist/angular-strap'
require 'bower/angular-strap/dist/angular-strap.tpl'
require 'bower/angular-permission/dist/angular-permission'
require 'bower/angular-utils-pagination/dirPagination'
require 'bower/ng-elif/src/elif'
require 'bower/angular-ui-select/dist/select.min'

require 'normalize.css'
require 'bower/bootstrap/dist/css/bootstrap.css'
require 'bower/angular-motion/dist/angular-motion.css'
require 'bower/angular-loading-bar/build/loading-bar.css'
require 'bower/ionicons/css/ionicons.css'
require 'bower/ng-tags-input/ng-tags-input.min.css'
require 'bower/angular-ui-select/dist/select.css'
require 'stylus/main.styl'

angular
  .element document
  .ready ->
    angular
      .module 'cinema', require './main.requires'
      .config require './main.config'
      .run require './main.run'
    angular.bootstrap document, ['cinema'], strictDi : on
