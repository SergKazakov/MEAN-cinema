module.exports = angular
  .module 'cinema.signup', []
  .config require './signup.config'
  .controller 'SignupCtrl', require './signup.controller'
  .directive 'passwordMatch', require './signup.directive'