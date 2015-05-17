signupConfig = ($stateProvider) ->
  $stateProvider.state 'signup',
    url : '/signup'
    templateUrl : require './signup.html'
    controller : 'SignupCtrl as vm'

signupConfig.$inject = ['$stateProvider']

module.exports = signupConfig
