adminMoviesConfig = ($stateProvider) ->
  $stateProvider.state 'admin.movies',
    url : '/movies'
    abstract : on
    template : '<ui-view></ui-view>'

adminMoviesConfig.$inject = ['$stateProvider']

module.exports = adminMoviesConfig
