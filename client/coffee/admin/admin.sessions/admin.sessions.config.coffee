adminSessionsConfig = ($stateProvider) ->
  $stateProvider.state 'admin.sessions.all',
    url : ''
    template : require './admin.sessions.jade'
    controller : 'AdminSessionsCtrl as vm'
    resolve :
      sessions : ['Session', (Session) ->
        Session.getSessionsByPage 1, 10
      ]

adminSessionsConfig.$inject = ['$stateProvider']

module.exports = adminSessionsConfig
