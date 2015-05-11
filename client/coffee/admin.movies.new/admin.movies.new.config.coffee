adminMoviesNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.moviesnew',
    url : '/movies/new'
    templateUrl : require './admin.movies.new.html'
    controller : 'AdminMoviesNewCtrl as vm'

module.exports = adminMoviesNewConfig
