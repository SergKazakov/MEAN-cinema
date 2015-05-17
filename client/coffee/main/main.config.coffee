mainConfig = ($urlRouterProvider, $locationProvider, $authProvider) ->
  $urlRouterProvider.otherwise '/'

  $authProvider.facebook
    clientId : '1653435961554069'

  $authProvider.google
    clientId : '476828247245-ve3nh4f0fbcg0elggblkvctse9a26821.apps.googleusercontent.com'

  $authProvider.github
    clientId : 'fdf1e069c66bb5a88004'

  $authProvider.twitter
    url : '/auth/twitter'

mainConfig.$inject = ['$urlRouterProvider', '$locationProvider', '$authProvider']

module.exports = mainConfig
