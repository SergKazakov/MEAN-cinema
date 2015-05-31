adminSessionsNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.sessionsnew',
    url : '/sessions/new'
    templateUrl : require '../admin.sessions.helper/admin.sessions.helper.html'
    controller : 'AdminSessionsNewCtrl as vm'

adminSessionsNewConfig.$inject = ['$stateProvider']

module.exports = adminSessionsNewConfig
