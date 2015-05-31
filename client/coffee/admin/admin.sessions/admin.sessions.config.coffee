adminSessionsConfig = ($stateProvider) ->
  $stateProvider.state 'admin.sessions',
    url : '/sessions'
    templateUrl : require './admin.sessions.html'
    controller : 'AdminSessionsCtrl as vm'
    resolve :
      sessions : ['Session', (Session) ->
        Session.getSessionsByPage 1
      ]

adminSessionsConfig.$inject = ['$stateProvider']

module.exports = adminSessionsConfig
