do ->
  angular
    .module 'cinema'
    .config ($stateProvider) ->
      $stateProvider.state 'login',
        url : '/login'
        templateUrl : 'partials/login'
        controller : 'LoginCtrl'

