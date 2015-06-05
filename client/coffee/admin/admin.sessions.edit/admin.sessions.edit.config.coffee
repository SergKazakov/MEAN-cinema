adminSessionsEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.sessions.edit',
    url : '/:sessionId/edit'
    template : require '../admin.sessions.helper/admin.sessions.helper.html'
    controller : 'AdminSessionsEditCtrl as vm'
    resolve :
      session : ['Session', '$stateParams', (Session, $stateParams) ->
        Session.getSession $stateParams.sessionId
      ]

adminSessionsEditConfig.$inject = ['$stateProvider']

module.exports = adminSessionsEditConfig
