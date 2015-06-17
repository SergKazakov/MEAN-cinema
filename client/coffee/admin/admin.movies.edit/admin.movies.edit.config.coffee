adminMoviesEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movies.edit',
    url : '/:movieId/edit'
    template : require '../admin.movies.helper/admin.movies.helper.jade'
    controller : 'AdminMoviesEditCtrl as vm'
    resolve :
      movie : ['Movie', '$stateParams', (Movie, $stateParams) ->
        Movie.getMovie $stateParams.movieId
      ]
      reviews : ['Movie', '$stateParams', (Movie, $stateParams) ->
        Movie.getMovieReviewsByPage $stateParams.movieId, 1, 0
      ]

adminMoviesEditConfig.$inject = ['$stateProvider']

module.exports = adminMoviesEditConfig
