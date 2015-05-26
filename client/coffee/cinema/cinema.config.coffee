cinemaConfig = ($stateProvider) ->
  $stateProvider.state 'cinema',
    url : '/cinema/:cinemaId'
    templateUrl : require './cinema.html'
    controller : 'CinemaCtrl as vm'
    resolve :
      cinema : ['Cinema', '$stateParams', (Cinema, $stateParams) ->
        Cinema.getCinema $stateParams.cinemaId
      ]

cinemaConfig.$inject = ['$stateProvider']

module.exports = cinemaConfig
