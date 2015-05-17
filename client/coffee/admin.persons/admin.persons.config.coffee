adminPersonsConfig = ($stateProvider) ->
  $stateProvider.state 'admin.persons',
    url : '/persons'
    templateUrl : require './admin.persons.html'
    controller : 'AdminPersonsCtrl as vm'

adminPersonsConfig.$inject = ['$stateProvider']

module.exports = adminPersonsConfig
