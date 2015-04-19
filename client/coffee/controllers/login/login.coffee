do ->
  angular
    .module 'cinema'
    .config ($stateProvider) ->
      $stateProvider.state 'login',
        url : '/login'
        controller : 'LoginCtrl as login'

