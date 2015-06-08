cinemaConfig = ($stateProvider) ->
  $stateProvider.state 'cinema',
    url : '/cinema/:cinemaId'
    template : require './cinema.jade'
    controller : 'CinemaCtrl as vm'
    resolve :
      cinema : ['Cinema', '$stateParams', (Cinema, $stateParams) ->
        Cinema.getCinema $stateParams.cinemaId
      ]
      sessions : ['Session', '$stateParams', (Session, $stateParams) ->
        Session.getSessionsByCinema $stateParams.cinemaId
      ]

cinemaConfig.$inject = ['$stateProvider']

module.exports = cinemaConfig
