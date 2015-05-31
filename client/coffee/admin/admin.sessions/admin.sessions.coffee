module.exports = angular
  .module 'cinema.admin.sessions', []
  .config require './admin.sessions.config'
  .controller 'AdminSessionsCtrl', require './admin.sessions.controller'
