adminMoviesEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movies.edit',
    url : '/:movieId/edit'
    templateUrl : require '../admin.movies.helper/admin.movies.helper.html'
    controller : 'AdminMoviesEditCtrl as vm'
    resolve :
      movie : ['Movie', '$stateParams', (Movie, $stateParams) ->
        Movie.getMovie $stateParams.movieId
      ]

adminMoviesEditConfig.$inject = ['$stateProvider']

module.exports = adminMoviesEditConfig
