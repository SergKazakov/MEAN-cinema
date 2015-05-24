homeConfig = ($stateProvider) ->
  $stateProvider.state 'home',
    url : '/'
    templateUrl : require './home.html'
    controller : 'HomeCtrl as vm'
    resolve :
      movies : ['Movie', (Movie) ->
        Movie.getMoviesByStatus 'now'
      ]

homeConfig.$inject = ['$stateProvider']

module.exports = homeConfig
