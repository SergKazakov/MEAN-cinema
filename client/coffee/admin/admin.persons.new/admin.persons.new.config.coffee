adminPersonsNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.personsnew',
    url : '/persons/new'
    templateUrl : require '../admin.person.helper/admin.person.helper.html'
    controller : 'AdminPersonsNewCtrl as vm'

adminPersonsNewConfig.$inject = ['$stateProvider']

module.exports = adminPersonsNewConfig
