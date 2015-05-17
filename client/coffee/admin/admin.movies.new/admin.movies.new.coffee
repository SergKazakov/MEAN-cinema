module.exports = angular
  .module 'cinema.admin.movies.new', []
  .config require './admin.movies.new.config'
  .controller 'AdminMoviesNewCtrl', require './admin.movies.new.controller'
