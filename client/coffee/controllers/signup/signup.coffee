do ->
  angular
    .module 'cinema'
    .config ($stateProvider) ->
      $stateProvider.state 'signup',
        url : '/signup'
        templateUrl : 'partials/signup'
        controller : 'SignupCtrl'
