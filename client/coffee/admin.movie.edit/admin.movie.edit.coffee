module.exports = angular
  .module 'cinema.admin.movie.edit', []
  .config require './admin.movie.edit.config'
  .controller 'AdminMovieEditCtrl', require './admin.movie.edit.controller'
