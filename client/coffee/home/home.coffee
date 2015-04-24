module.exports = angular
  .module 'cinema.home', []
  .config require './home.config'
  .controller 'HomeCtrl', require './home.controller'