module.exports = angular
  .module 'cinema.admin.cinema.edit', [
    require('../admin.cinema.helper/admin.cinema.helper').name
  ]
  .config require './admin.cinema.edit.config'
  .controller 'AdminCinemaEditCtrl', require './admin.cinema.edit.controller'
