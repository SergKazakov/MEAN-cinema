loginConfig = ($stateProvider) ->
  $stateProvider.state 'login',
    url : '/login'
    templateUrl : require './login.html'
    controller : 'LoginCtrl as vm'

loginConfig.$inject = ['$stateProvider']

module.exports = loginConfig
