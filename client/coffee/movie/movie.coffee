module.exports = angular
  .module 'cinema.movie', []
  .config require './movie.config'
  .controller 'MovieCtrl', require './movie.controller'
