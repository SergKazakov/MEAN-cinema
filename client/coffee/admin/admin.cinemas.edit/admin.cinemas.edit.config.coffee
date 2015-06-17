adminCinemasEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemas.edit',
    url : '/:cinemaId/edit'
    template : require '../admin.cinemas.helper/admin.cinemas.helper.jade'
    controller : 'AdminCinemasEditCtrl as vm'
    resolve :
      cinema : ['Cinema', '$stateParams', (Cinema, $stateParams) ->
        Cinema.getCinema $stateParams.cinemaId
      ]
      reviews : ['Cinema', '$stateParams', (Cinema, $stateParams) ->
        Cinema.getCinemaReviewsByPage $stateParams.cinemaId, 1, 0
      ]

adminCinemasEditConfig.$inject = ['$stateProvider']

module.exports = adminCinemasEditConfig
