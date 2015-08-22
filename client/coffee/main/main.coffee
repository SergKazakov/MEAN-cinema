require 'angular'
require 'satellizer'
require 'ng-file-upload'
require 'angular-permission'
require 'angular-utils-pagination'
require 'angular-loading-bar'
require 'ng-tags-input'

require 'npm/angular-strap/dist/angular-strap'
require 'npm/angular-strap/dist/angular-strap.tpl'
require 'npm/angular-ui-bootstrap/ui-bootstrap.min'
require 'npm/angular-ui-bootstrap/ui-bootstrap-tpls.min'
require 'npm/ui-select/dist/select.min'
require 'bower/ng-elif/src/elif'

require 'normalize.css'
require 'npm/bootstrap/dist/css/bootstrap.css'
require 'npm/angular-motion/dist/angular-motion.css'
require 'npm/angular-loading-bar/build/loading-bar.css'
require 'npm/ng-tags-input/build/ng-tags-input.css'
require 'npm/ui-select/dist/select.css'
require 'bower/ionicons/css/ionicons.css'
require 'stylus/main.styl'

angular
  .element document
  .ready ->
    angular
      .module 'cinema', require './main.requires'
      .config require './main.config'
      .run require './main.run'
    angular.bootstrap document, ['cinema'], strictDi : on
