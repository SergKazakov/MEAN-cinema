adminMovieEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movieedit',
    url : '/movie/:movieId/edit'
    templateUrl : require './admin.movie.edit.html'
    controller : 'AdminMovieEditCtrl as vm'

adminMovieEditConfig.$inject = ['$stateProvider']

module.exports = adminMovieEditConfig
