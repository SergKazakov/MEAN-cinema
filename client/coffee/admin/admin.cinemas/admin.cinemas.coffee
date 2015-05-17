module.exports = angular
  .module 'cinema.admin.cinemas', []
  .config require './admin.cinemas.config'
  .controller 'AdminCinemasCtrl', require './admin.cinemas.controller'
