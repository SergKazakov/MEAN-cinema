module.exports = angular
  .module 'cinema.admin.sessions.edit', []
  .config require './admin.sessions.edit.config'
  .controller 'AdminSessionsEditCtrl', require './admin.sessions.edit.controller'
