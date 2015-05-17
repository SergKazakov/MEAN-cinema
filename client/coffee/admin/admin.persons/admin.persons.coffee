module.exports = angular
  .module 'cinema.admin.persons', []
  .config require './admin.persons.config'
  .controller 'AdminPersonsCtrl', require './admin.persons.controller'
