adminUsersConfig = ($stateProvider) ->
  $stateProvider.state 'admin.users.all',
    url : ''
    template : require './admin.users.jade'
    controller : 'AdminUsersCtrl as vm'
    resolve :
      users : ['User', (User) ->
        User.getUsersByPage 1, 10
      ]

adminUsersConfig.$inject = ['$stateProvider']

module.exports = adminUsersConfig
