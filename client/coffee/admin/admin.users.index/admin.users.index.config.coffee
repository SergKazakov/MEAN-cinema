adminUsersConfig = ($stateProvider) ->
  $stateProvider.state 'admin.users',
    url : '/users'
    abstract : on
    template : '<ui-view></ui-view>'

adminUsersConfig.$inject = ['$stateProvider']

module.exports = adminUsersConfig
