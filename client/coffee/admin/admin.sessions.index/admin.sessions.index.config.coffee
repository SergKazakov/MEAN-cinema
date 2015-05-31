adminSessionsConfig = ($stateProvider) ->
  $stateProvider.state 'admin.sessions',
    url : '/sessions'
    abstract : on
    template : '<ui-view></ui-view>'

adminSessionsConfig.$inject = ['$stateProvider']

module.exports = adminSessionsConfig
