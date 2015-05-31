module.exports = angular
  .module 'cinema.admin.session.edit', []
  .config require './admin.session.edit.config'
  .controller 'AdminSessionEditCtrl', require './admin.session.edit.controller'
