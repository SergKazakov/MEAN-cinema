adminCinemasConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemas.all',
    url : ''
    template : require './admin.cinemas.html'
    controller : 'AdminCinemasCtrl as vm'
    resolve :
      cinemas : ['Cinema', (Cinema) ->
        Cinema.getCinemasByPage 1
      ]

adminCinemasConfig.$inject = ['$stateProvider']

module.exports = adminCinemasConfig
