signupConfig = ($stateProvider) ->
  $stateProvider.state 'signup',
    url : '/signup'
    templateUrl : 'partials/signup'
    controller : 'SignupCtrl as vm'

module.exports = signupConfig
