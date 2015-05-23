mainConfig = ($urlRouterProvider, $locationProvider, $authProvider) ->
  $urlRouterProvider.otherwise '/'

  $authProvider.facebook
    clientId : process.env.FACEBOOK_ID or '1653435961554069'

  $authProvider.google
    clientId : process.env.GOOGLE_ID or '476828247245-ve3nh4f0fbcg0elggblkvctse9a26821.apps.googleusercontent.com'

  $authProvider.github
    clientId : process.env.GITHUB_ID or 'fdf1e069c66bb5a88004'

  $authProvider.twitter
    url : process.env.TWITTER_URL or '/auth/twitter'

mainConfig.$inject = ['$urlRouterProvider', '$locationProvider', '$authProvider']

module.exports = mainConfig
