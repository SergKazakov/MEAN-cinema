adminMovieEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movieedit',
    url : '/movie/:movieId/edit'
    templateUrl : require './admin.movie.edit.html'
    controller : 'AdminMovieEditCtrl as vm'

module.exports = adminMovieEditConfig
