module.exports = angular
  .module 'cinema.api', []
  .factory 'Movie', require './api.movie.factory'
  .factory 'Person', require './api.person.factory'
  .factory 'Cinema', require './api.cinema.factory'
  .factory 'Session', require './api.session.factory'
  .factory 'Hall', require './api.hall.factory'
