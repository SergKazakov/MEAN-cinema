adminMoviesConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movies',
    url : '/movies'
    templateUrl : require './admin.movies.html'
    controller : 'AdminMoviesCtrl as vm'

adminMoviesConfig.$inject = ['$stateProvider']

module.exports = adminMoviesConfig
