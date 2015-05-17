adminMoviesNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.moviesnew',
    url : '/movies/new'
    templateUrl : require './admin.movies.new.html'
    controller : 'AdminMoviesNewCtrl as vm'

adminMoviesNewConfig.$inject = ['$stateProvider']

module.exports = adminMoviesNewConfig
