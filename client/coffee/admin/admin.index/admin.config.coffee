adminConfig = ($stateProvider) ->
  $stateProvider.state 'admin',
    url : '/admin'
    absract : on
    templateUrl : require './admin.html'
    controller : 'AdminCtrl as vm'
    data :
      permissions :
        only : ['admin']

adminConfig.$inject = ['$stateProvider']

module.exports = adminConfig
