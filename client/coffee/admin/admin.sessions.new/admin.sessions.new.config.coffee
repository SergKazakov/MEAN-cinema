adminSessionsNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.sessions.new',
    url : '/new'
    template : require '../admin.sessions.helper/admin.sessions.helper.jade'
    controller : 'AdminSessionsNewCtrl as vm'

adminSessionsNewConfig.$inject = ['$stateProvider']

module.exports = adminSessionsNewConfig
