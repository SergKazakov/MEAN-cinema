adminCinemasNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemasnew',
    url : '/cinemas/new'
    templateUrl : require './admin.cinemas.new.html'
    controller : 'AdminCinemasNewCtrl as vm'

adminCinemasNewConfig.$inject = ['$stateProvider']

module.exports = adminCinemasNewConfig
