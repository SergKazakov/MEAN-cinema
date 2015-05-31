adminMoviesNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movies.new',
    url : '/new'
    templateUrl : require '../admin.movie.helper/admin.movie.helper.html'
    controller : 'AdminMoviesNewCtrl as vm'

adminMoviesNewConfig.$inject = ['$stateProvider']

module.exports = adminMoviesNewConfig
