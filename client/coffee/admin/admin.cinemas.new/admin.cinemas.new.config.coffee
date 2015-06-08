adminCinemasNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemas.new',
    url : '/new'
    template : require '../admin.cinemas.helper/admin.cinemas.helper.jade'
    controller : 'AdminCinemasNewCtrl as vm'

adminCinemasNewConfig.$inject = ['$stateProvider']

module.exports = adminCinemasNewConfig
