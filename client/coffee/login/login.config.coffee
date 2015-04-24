loginConfig = ($stateProvider) ->
  $stateProvider.state 'login',
    url : '/login'
    templateUrl : 'partials/login'
    controller : 'LoginCtrl'

module.exports = loginConfig