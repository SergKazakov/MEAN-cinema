module.exports = angular
  .module 'cinema.session', []
  .config require './session.config'
  .controller 'SessionCtrl', require './session.controller'
