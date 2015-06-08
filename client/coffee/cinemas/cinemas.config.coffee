cinemasConfig = ($stateProvider) ->
  $stateProvider.state 'cinemas',
    url : '/cinemas'
    template : require './cinemas.jade'
    controller : 'CinemasCtrl as vm'
    resolve :
      cinemas : ['Cinema', (Cinema) ->
        Cinema.getCinemas()
      ]

cinemasConfig.$inject = ['$stateProvider']

module.exports = cinemasConfig
