adminMovieEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movieedit',
    url : '/movie/:movieId/edit'
    templateUrl : require './admin.movie.edit.html'
    controller : 'AdminMovieEditCtrl as vm'
    resolve :
      movie : ['Movie', '$stateParams', (Movie, $stateParams) ->
        Movie.getMovie $stateParams.movieId
      ]

adminMovieEditConfig.$inject = ['$stateProvider']

module.exports = adminMovieEditConfig
