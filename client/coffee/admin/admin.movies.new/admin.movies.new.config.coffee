adminMoviesNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movies.new',
    url : '/new'
    template : require '../admin.movies.helper/admin.movies.helper.html'
    controller : 'AdminMoviesNewCtrl as vm'

adminMoviesNewConfig.$inject = ['$stateProvider']

module.exports = adminMoviesNewConfig
