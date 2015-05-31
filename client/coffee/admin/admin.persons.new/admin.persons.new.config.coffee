adminPersonsNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.persons.new',
    url : '/new'
    templateUrl : require '../admin.person.helper/admin.person.helper.html'
    controller : 'AdminPersonsNewCtrl as vm'

adminPersonsNewConfig.$inject = ['$stateProvider']

module.exports = adminPersonsNewConfig
