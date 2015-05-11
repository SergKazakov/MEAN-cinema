homeConfig = ($stateProvider) ->
  $stateProvider.state 'home',
    url : '/'
    templateUrl : require './home.html'
    controller : 'HomeCtrl as vm'

module.exports = homeConfig
