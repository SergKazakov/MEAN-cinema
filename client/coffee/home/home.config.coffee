homeConfig = ($stateProvider) ->
  $stateProvider.state 'home',
    url : '/'
    templateUrl : 'partials/home'
    controller : 'HomeCtrl as vm'

module.exports = homeConfig
