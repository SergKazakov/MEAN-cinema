module.exports = angular
  .module 'cinema.admin.hall.edit', []
  .config require './admin.hall.edit.config'
  .controller 'AdminHallEditCtrl', require './admin.hall.edit.controller'
