module.exports = angular
  .module 'cinema.admin.users', []
  .config require './admin.users.config'
  .controller 'AdminUsersCtrl', require './admin.users.controller'
