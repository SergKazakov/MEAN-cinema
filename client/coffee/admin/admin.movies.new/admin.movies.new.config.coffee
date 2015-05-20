adminMoviesNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.moviesnew',
    url : '/movies/new'
    templateUrl : require '../admin.movie.helper/admin.movie.helper.html'
    controller : 'AdminMoviesNewCtrl as vm'

adminMoviesNewConfig.$inject = ['$stateProvider']

module.exports = adminMoviesNewConfig
