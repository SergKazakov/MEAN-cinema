module.exports = angular
  .module 'cinema.admin.movies', []
  .config require './admin.movies.config'
  .controller 'AdminMoviesCtrl', require './admin.movies.controller'
