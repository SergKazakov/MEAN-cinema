module.exports = angular
  .module 'cinema.admins.movie.edit', []
  .config require './admin.movies.edit.config'
  .controller 'AdminMoviesEditCtrl', require './admin.movies.edit.controller'
