homeConfig = ($stateProvider) ->
  $stateProvider.state 'home',
    url : '/'
    templateUrl : require './home.html'
    controller : 'HomeCtrl as vm'

homeConfig.$inject = ['$stateProvider']

module.exports = homeConfig
