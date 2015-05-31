adminSessionEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.sessions.edit',
    url : '/:sessionId/edit'
    templateUrl : require '../admin.sessions.helper/admin.sessions.helper.html'
    controller : 'AdminSessionEditCtrl as vm'
    resolve :
      session : ['Session', '$stateParams', (Session, $stateParams) ->
        Session.getSession $stateParams.sessionId
      ]

adminSessionEditConfig.$inject = ['$stateProvider']

module.exports = adminSessionEditConfig
