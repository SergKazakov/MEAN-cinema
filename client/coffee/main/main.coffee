require 'normalize.css'
require '../../stylus/main.styl'

angular = require 'angular'
require 'satellizer'
require '../../bower_components/angular-loading-bar/build/loading-bar.min.js'
require '../../bower_components/angular-strap/dist/angular-strap'
require '../../bower_components/angular-strap/dist/angular-strap.tpl'

angular
  .module 'cinema', [
    'mgcrea.ngStrap'
    'satellizer'
    'angular-loading-bar'
    require 'angular-resource'
    require 'angular-messages'
    require 'angular-ui-router'
    require 'angular-animate'
    require('../navbar/navbar').name
    require('../home/home').name
    require('../login/login').name
    require('../signup/signup').name
    require('../account/account').name
    require('../profile/profile').name
  ]
  .config require './main.config'
