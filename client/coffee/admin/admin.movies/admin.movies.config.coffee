adminMoviesConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movies.all',
    url : ''
    template : require './admin.movies.jade'
    controller : 'AdminMoviesCtrl as vm'
    resolve :
      movies : ['Movie', (Movie) ->
        Movie.getMoviesByPage 1, 10
      ]

adminMoviesConfig.$inject = ['$stateProvider']

module.exports = adminMoviesConfig
