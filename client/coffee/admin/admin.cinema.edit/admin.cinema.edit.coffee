module.exports = angular
  .module 'cinema.admin.cinema.edit', []
  .config require './admin.cinema.edit.config'
  .controller 'AdminCinemaEditCtrl', require './admin.cinema.edit.controller'
