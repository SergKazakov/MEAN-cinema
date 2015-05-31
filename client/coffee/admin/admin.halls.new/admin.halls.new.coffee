module.exports = angular
  .module 'cinema.admin.halls.new', []
  .config require './admin.halls.new.config'
  .controller 'AdminHallsNewCtrl', require './admin.halls.new.controller'
