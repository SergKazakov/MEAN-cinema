module.exports = angular
  .module 'cinema.navbar', []
  .controller 'NavbarCtrl', require './navbar.controller'
  .directive 'navbar', require './navbar.directive'
