adminCinemasConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemas',
    url : '/cinemas'
    abstract : on
    template : '<ui-view></ui-view>'

adminCinemasConfig.$inject = ['$stateProvider']

module.exports = adminCinemasConfig
