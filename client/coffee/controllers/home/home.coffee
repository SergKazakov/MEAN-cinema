do ->
  angular
    .module 'cinema'
    .config ($stateProvider) ->
      $stateProvider.state 'home',
        url : '/'
        templateUrl : 'partials/home'
        controller : 'HomeCtrl as home'
