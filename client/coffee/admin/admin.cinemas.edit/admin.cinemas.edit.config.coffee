adminCinemasEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemas.edit',
    url : '/:cinemaId/edit'
    templateUrl : require '../admin.cinemas.helper/admin.cinemas.helper.html'
    controller : 'AdminCinemasEditCtrl as vm'
    resolve :
      cinema : ['Cinema', '$stateParams', (Cinema, $stateParams) ->
        Cinema.getCinema $stateParams.cinemaId
      ]

adminCinemasEditConfig.$inject = ['$stateProvider']

module.exports = adminCinemasEditConfig
