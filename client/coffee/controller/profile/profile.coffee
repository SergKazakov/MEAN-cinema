do ->
  angular
    .module 'cinema'
    .config ($stateProvider) ->
      $stateProvider.state 'profile',
        url:          '/profile'
        templateUrl:  'partials/profile'
        controller:   'ProfileCtrl as profile'
        data:
          requiresLogin: on
