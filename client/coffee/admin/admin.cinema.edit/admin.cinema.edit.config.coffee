adminCinemaEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemaedit',
    url : '/cinema/:cinemaId/edit'
    template : '<admin-cinema action="vm.editCinema()" cinema="vm.cinema" file="vm.file"></admin-cinema>'
    controller : 'AdminCinemaEditCtrl as vm'
    resolve :
      cinema : ['Cinema', '$stateParams', (Cinema, $stateParams) ->
        Cinema.getCinema $stateParams.cinemaId
      ]

adminCinemaEditConfig.$inject = ['$stateProvider']

module.exports = adminCinemaEditConfig
