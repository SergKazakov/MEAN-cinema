movieConfig = ($stateProvider) ->
  $stateProvider.state 'movie',
    url : '/movie/:movieId'
    templateUrl : require './movie.html'
    controller : 'MovieCtrl as vm'
    resolve :
      movie : ['Movie', '$stateParams', (Movie, $stateParams) ->
        Movie.getMovie $stateParams.movieId
      ]

movieConfig.$inject = ['$stateProvider']

module.exports = movieConfig
