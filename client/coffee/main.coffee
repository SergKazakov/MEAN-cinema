require 'normalize.css'
require '../stylus/main.styl'

angular = require 'angular'
require 'satellizer'
require '../bower_components/angular-strap/dist/angular-strap'
require '../bower_components/angular-strap/dist/angular-strap.tpl'

angular
  .module 'cinema', [
    'mgcrea.ngStrap'
    'satellizer'
    require 'angular-resource'
    require 'angular-messages'
    require 'angular-ui-router'
    require 'angular-animate'
    require('./navbar/navbar').name
    require('./home/home').name
    require('./login/login').name
    require('./signup/signup').name
    require('./account/account').name
    require('./profile/profile').name
  ]
  .config ($urlRouterProvider, $locationProvider, $authProvider) ->
    $urlRouterProvider.otherwise '/'
    $locationProvider.html5Mode on

    $authProvider.facebook
      clientId : '1653435961554069'

    $authProvider.google
      clientId : '476828247245-ve3nh4f0fbcg0elggblkvctse9a26821.apps.googleusercontent.com'

    $authProvider.github
      clientId : '0ba2600b1dbdb756688b'

    $authProvider.linkedin
      clientId : '77cw786yignpzj'

    $authProvider.yahoo
      clientId : 'dj0yJmk9SDVkM2RhNWJSc2ZBJmQ9WVdrOWIzVlFRMWxzTXpZbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD0yYw--'

    $authProvider.twitter
      url : '/auth/twitter'

    $authProvider.live
      clientId : '0000000048152D9F'

    $authProvider.oauth2
      name : 'foursquare'
      url : '/auth/foursquare'
      clientId : 'MTCEJ3NGW2PNNB31WOSBFDSAD4MTHYVAZ1UKIULXZ2CVFC2K'
      redirectUri : window.location.origin or window.location.protocol + '//' + window.location.host
      authorizationEndpoint : 'https://foursquare.com/oauth2/authenticate'

