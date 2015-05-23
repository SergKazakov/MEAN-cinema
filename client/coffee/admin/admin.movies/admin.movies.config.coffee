adminMoviesConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movies',
    url : '/movies'
    templateUrl : require './admin.movies.html'
    controller : 'AdminMoviesCtrl as vm'
    resolve :
      movies : ['Movie', (Movie) ->
        Movie.getMoviesByPage 1
      ]

adminMoviesConfig.$inject = ['$stateProvider']

module.exports = adminMoviesConfig
