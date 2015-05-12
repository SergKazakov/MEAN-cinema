module.exports = angular
  .module 'cinema.admin.person.edit', []
  .config require './admin.person.edit.config'
  .controller 'AdminPersonEditCtrl', require './admin.person.edit.controller'
