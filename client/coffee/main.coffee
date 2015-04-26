require 'normalize.css'
require '../stylus/main.styl'

angular = require 'angular'
require 'satellizer'
require 'angular-loading-bar'
require '../bower_components/angular-strap/dist/angular-strap'
require '../bower_components/angular-strap/dist/angular-strap.tpl'

angular
  .module 'cinema', [
    'mgcrea.ngStrap'
    'satellizer'
    'angular-loading-bar'
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
      clientId : 'fdf1e069c66bb5a88004'

    $authProvider.twitter
      url : '/auth/twitter'
