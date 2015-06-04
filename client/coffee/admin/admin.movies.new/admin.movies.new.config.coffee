adminMoviesNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movies.new',
    url : '/new'
    templateUrl : require '../admin.movies.helper/admin.movies.helper.html'
    controller : 'AdminMoviesNewCtrl as vm'

adminMoviesNewConfig.$inject = ['$stateProvider']

module.exports = adminMoviesNewConfig
