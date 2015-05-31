adminHallsConfig = ($stateProvider) ->
  $stateProvider.state 'admin.halls',
    url : '/halls'
    abstract : on
    template : '<ui-view></ui-view>'

adminHallsConfig.$inject = ['$stateProvider']

module.exports = adminHallsConfig
