require 'bower/ng-tags-input/ng-tags-input.min'

module.exports = angular
  .module 'cinema.admin', require './admin.requires'
  .config require './admin.config'
  .controller 'AdminCtrl', require './admin.controller.coffee'
