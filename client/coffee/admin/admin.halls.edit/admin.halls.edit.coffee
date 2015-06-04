module.exports = angular
  .module 'cinema.admin.halls.edit', []
  .config require './admin.halls.edit.config'
  .controller 'AdminHallsEditCtrl', require './admin.halls.edit.controller'
