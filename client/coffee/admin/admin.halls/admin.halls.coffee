module.exports = angular
  .module 'cinema.admin.halls', []
  .config require './admin.halls.config'
  .controller 'AdminHallsCtrl', require './admin.halls.controller'
