module.exports = angular
  .module 'cinema.admin.persons.edit', []
  .config require './admin.persons.edit.config'
  .controller 'AdminPersonsEditCtrl', require './admin.persons.edit.controller'
