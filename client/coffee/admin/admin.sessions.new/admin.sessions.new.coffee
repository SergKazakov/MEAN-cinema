module.exports = angular
  .module 'cinema.admin.sessions.new', []
  .config require './admin.sessions.new.config'
  .controller 'AdminSessionsNewCtrl', require './admin.sessions.new.controller'
