module.exports = angular
  .module 'cinema.admin.cinemas.new', []
  .config require './admin.cinemas.new.config'
  .controller 'AdminCinemasNewCtrl', require './admin.cinemas.new.controller'
