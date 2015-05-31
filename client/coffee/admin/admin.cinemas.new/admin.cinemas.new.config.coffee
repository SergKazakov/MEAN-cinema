adminCinemasNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemas.new',
    url : '/new'
    templateUrl : require '../admin.cinema.helper/admin.cinema.helper.html'
    controller : 'AdminCinemasNewCtrl as vm'

adminCinemasNewConfig.$inject = ['$stateProvider']

module.exports = adminCinemasNewConfig
