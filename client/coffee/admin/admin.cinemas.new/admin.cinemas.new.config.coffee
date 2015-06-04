adminCinemasNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemas.new',
    url : '/new'
    templateUrl : require '../admin.cinemas.helper/admin.cinemas.helper.html'
    controller : 'AdminCinemasNewCtrl as vm'

adminCinemasNewConfig.$inject = ['$stateProvider']

module.exports = adminCinemasNewConfig
