movieConfig = ($stateProvider) ->
  $stateProvider.state 'movie',
    url : '/movies/:movieId'
    template : require './movie.jade'
    controller : 'MovieCtrl as vm'
    resolve :
      movie : ['Movie', '$stateParams', (Movie, $stateParams) ->
        Movie.getMovie $stateParams.movieId
      ]
      sessions : ['Session', '$stateParams', (Session, $stateParams) ->
        Session.getSessionsByMovie $stateParams.movieId
      ]
      reviews : ['Movie', '$stateParams', (Movie, $stateParams) ->
        Movie.getMovieReviewsByPage $stateParams.movieId, 1, 10
      ]

movieConfig.$inject = ['$stateProvider']

module.exports = movieConfig
