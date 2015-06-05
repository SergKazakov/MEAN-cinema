homeConfig = ($stateProvider) ->
  $stateProvider.state 'home',
    url : '/'
    template : require './home.html'
    controller : 'HomeCtrl as vm'
    resolve :
      newMovies : ['Movie', (Movie) ->
        Movie.getMoviesByStatus 'now'
      ]
      upcomingMovies : ['Movie', (Movie) ->
        Movie.getMoviesByStatus 'upcoming'
      ]

homeConfig.$inject = ['$stateProvider']

module.exports = homeConfig
