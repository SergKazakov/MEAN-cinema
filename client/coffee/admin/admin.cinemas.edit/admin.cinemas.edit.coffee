module.exports = angular
  .module 'cinema.admin.cinemas.edit', []
  .config require './admin.cinemas.edit.config'
  .controller 'AdminCinemasEditCtrl', require './admin.cinemas.edit.controller'
