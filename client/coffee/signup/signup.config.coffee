signupConfig = ($stateProvider) ->
  $stateProvider.state 'signup',
    url : '/signup'
    templateUrl : 'partials/signup'
    controller : 'SignupCtrl'

module.exports = signupConfig