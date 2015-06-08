loginConfig = ($stateProvider) ->
  $stateProvider.state 'login',
    url : '/login'
    template : require './login.jade'
    controller : 'LoginCtrl as vm'

loginConfig.$inject = ['$stateProvider']

module.exports = loginConfig
