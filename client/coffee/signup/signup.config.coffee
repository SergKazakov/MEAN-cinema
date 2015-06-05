signupConfig = ($stateProvider) ->
  $stateProvider.state 'signup',
    url : '/signup'
    template : require './signup.html'
    controller : 'SignupCtrl as vm'

signupConfig.$inject = ['$stateProvider']

module.exports = signupConfig
