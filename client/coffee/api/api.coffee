module.exports = angular
  .module 'cinema.api', []
  .factory 'Movie', require './api.movie.factory'
  .factory 'Person', require './api.person.factory'
