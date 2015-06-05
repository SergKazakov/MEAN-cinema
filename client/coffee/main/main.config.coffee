mainConfig = ($urlRouterProvider, $locationProvider, $authProvider) ->
  $urlRouterProvider.otherwise '/'

  $authProvider.facebook
    clientId : process.env.FACEBOOK_ID

  $authProvider.google
    clientId : process.env.GOOGLE_ID

  $authProvider.github
    clientId : process.env.GITHUB_ID

  $authProvider.twitter
    url : process.env.TWITTER_URL

mainConfig.$inject = ['$urlRouterProvider', '$locationProvider', '$authProvider']

module.exports = mainConfig
