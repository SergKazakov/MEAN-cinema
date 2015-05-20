adminCinemasNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemasnew',
    url : '/cinemas/new'
    templateUrl : require '../admin.cinema.helper/admin.cinema.helper.html'
    controller : 'AdminCinemasNewCtrl as vm'

adminCinemasNewConfig.$inject = ['$stateProvider']

module.exports = adminCinemasNewConfig
