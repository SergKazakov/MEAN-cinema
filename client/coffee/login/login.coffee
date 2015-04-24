module.exports = angular
  .module 'cinema.login', []
  .config require './login.config'
  .controller 'LoginCtrl', require './login.controller'