movieConfig = ($stateProvider) ->
  $stateProvider.state 'movie',
    url : '/movie/:movieId'
    template : require './movie.html'
    controller : 'MovieCtrl as vm'
    resolve :
      movie : ['Movie', '$stateParams', (Movie, $stateParams) ->
        Movie.getMovie $stateParams.movieId
      ]
      sessions : ['Session', '$stateParams', (Session, $stateParams) ->
        Session.getSessionsByMovie $stateParams.movieId
      ]

movieConfig.$inject = ['$stateProvider']

module.exports = movieConfig
