adminCinemaEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemaedit',
    url : '/cinema/:cinemaId/edit'
    templateUrl : require '../admin.cinema.helper/admin.cinema.helper.html'
    controller : 'AdminCinemaEditCtrl as vm'
    resolve :
      cinema : ['Cinema', '$stateParams', (Cinema, $stateParams) ->
        Cinema.getCinema $stateParams.cinemaId
      ]

adminCinemaEditConfig.$inject = ['$stateProvider']

module.exports = adminCinemaEditConfig
