adminCinemasConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemas',
    url : '/cinemas'
    templateUrl : require './admin.cinemas.html'
    controller : 'AdminCinemasCtrl as vm'

adminCinemasConfig.$inject = ['$stateProvider']

module.exports = adminCinemasConfig
