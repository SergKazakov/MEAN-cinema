loginConfig = ($stateProvider) ->
  $stateProvider.state 'login',
    url : '/login'
    templateUrl : 'partials/login'
    controller : 'LoginCtrl as vm'

module.exports = loginConfig
