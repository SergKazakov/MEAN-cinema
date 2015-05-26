module.exports = angular
  .module 'cinema.cinemas', []
  .config require './cinemas.config'
  .controller 'CinemasCtrl', require './cinemas.controller'
