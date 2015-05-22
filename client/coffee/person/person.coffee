module.exports = angular
  .module 'cinema.person', []
  .config require './person.config'
  .controller 'PersonCtrl', require './person.controller'
