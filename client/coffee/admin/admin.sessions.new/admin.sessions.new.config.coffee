adminSessionsNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.sessions.new',
    url : '/new'
    templateUrl : require '../admin.sessions.helper/admin.sessions.helper.html'
    controller : 'AdminSessionsNewCtrl as vm'

adminSessionsNewConfig.$inject = ['$stateProvider']

module.exports = adminSessionsNewConfig
