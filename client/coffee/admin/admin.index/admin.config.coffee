adminConfig = ($stateProvider) ->
  $stateProvider.state 'admin',
    url : '/admin'
    absract : on
    templateUrl : require './admin.html'
    data :
      permissions :
        only : ['admin']

adminConfig.$inject = ['$stateProvider']

module.exports = adminConfig
