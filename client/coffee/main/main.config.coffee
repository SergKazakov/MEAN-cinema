mainConfig = ($urlRouterProvider, $locationProvider, $authProvider, $alertProvider) ->
  $urlRouterProvider.otherwise '/'

  $authProvider.facebook
    clientId : process.env.FACEBOOK_ID

  $authProvider.google
    clientId : process.env.GOOGLE_ID

  $authProvider.github
    clientId : process.env.GITHUB_ID

  $authProvider.twitter
    url : process.env.TWITTER_URL

  angular.extend $alertProvider.defaults,
    animation : 'fadeZoomFadeDown'
    type : 'material'
    duration : 3

mainConfig.$inject = ['$urlRouterProvider', '$locationProvider', '$authProvider', '$alertProvider']

module.exports = mainConfig
