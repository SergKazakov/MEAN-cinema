module.exports = angular
  .module 'cinema.admin.persons.new', []
  .config require './admin.persons.new.config'
  .controller 'AdminPersonsNewCtrl', require './admin.persons.new.controller'
