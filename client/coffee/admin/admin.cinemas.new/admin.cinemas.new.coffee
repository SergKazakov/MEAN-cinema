module.exports = angular
  .module 'cinema.admin.cinemas.new', [
    require('../admin.cinema.helper/admin.cinema.helper').name
  ]
  .config require './admin.cinemas.new.config'
  .controller 'AdminCinemasNewCtrl', require './admin.cinemas.new.controller'
