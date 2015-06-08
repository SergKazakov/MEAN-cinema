signupConfig = ($stateProvider) ->
  $stateProvider.state 'signup',
    url : '/signup'
    template : require './signup.jade'
    controller : 'SignupCtrl as vm'

signupConfig.$inject = ['$stateProvider']

module.exports = signupConfig
