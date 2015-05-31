adminMovieEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movies.edit',
    url : '/:movieId/edit'
    templateUrl : require '../admin.movie.helper/admin.movie.helper.html'
    controller : 'AdminMovieEditCtrl as vm'
    resolve :
      movie : ['Movie', '$stateParams', (Movie, $stateParams) ->
        Movie.getMovie $stateParams.movieId
      ]

adminMovieEditConfig.$inject = ['$stateProvider']

module.exports = adminMovieEditConfig
