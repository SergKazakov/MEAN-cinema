homeConfig = ($stateProvider) ->
  $stateProvider.state 'home',
    url : '/'
    templateUrl : 'partials/home'
    controller : 'HomeCtrl as home'

module.exports = homeConfig