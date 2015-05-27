cinemasConfig = ($stateProvider) ->
  $stateProvider.state 'cinemas',
    url : '/cinemas'
    templateUrl : require './cinemas.html'
    controller : 'CinemasCtrl as vm'
    resolve :
      cinemas : ['Cinema', (Cinema) ->
        Cinema.getCinemas()
      ]

cinemasConfig.$inject = ['$stateProvider']

module.exports = cinemasConfig