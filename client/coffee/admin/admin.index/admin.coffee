module.exports = angular
  .module 'cinema.admin', []
  .config require './admin.config'
  .controller 'AdminCtrl', require './admin.controller.coffee'
