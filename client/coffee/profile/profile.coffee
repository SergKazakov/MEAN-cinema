module.exports = angular
  .module 'cinema.profile', []
  .config require './profile.config'
  .controller 'ProfileCtrl', require './profile.controller'