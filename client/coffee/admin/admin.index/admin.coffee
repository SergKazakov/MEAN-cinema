require 'bower/ng-tags-input/ng-tags-input.min'

module.exports = angular
  .module 'cinema.admin', ['ngTagsInput']
  .config require './admin.config'
  .controller 'AdminCtrl', require './admin.controller.coffee'
