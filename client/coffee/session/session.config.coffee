sessionConfig = ($stateProvider) ->
  $stateProvider.state 'session',
    url : '/sessions/:sessionId'
    template : require './session.jade'
    controller : 'SessionCtrl as vm'
    resolve :
      session : ['Session', '$stateParams', (Session, $stateParams) ->
        Session.getSession $stateParams.sessionId
      ]

sessionConfig.$inject = ['$stateProvider']

module.exports = sessionConfig
