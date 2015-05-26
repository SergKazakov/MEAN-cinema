module.exports = angular
  .module 'cinema.cinema', []
  .config require './cinema.config'
  .controller 'CinemaCtrl', require './cinema.controller'
