cinemaConfig = ($stateProvider) ->
  $stateProvider.state 'cinema',
    url : '/cinemas/:cinemaId'
    template : require './cinema.jade'
    controller : 'CinemaCtrl as vm'
    resolve :
      cinema : ['Cinema', '$stateParams', (Cinema, $stateParams) ->
        Cinema.getCinema $stateParams.cinemaId
      ]
      sessions : ['Cinema', '$stateParams', (Cinema, $stateParams) ->
        Cinema.getSessions $stateParams.cinemaId
      ]
      reviews : ['Cinema', '$stateParams', (Cinema, $stateParams) ->
        Cinema.getCinemaReviewsByPage $stateParams.cinemaId, 1, 10
      ]

cinemaConfig.$inject = ['$stateProvider']

module.exports = cinemaConfig
