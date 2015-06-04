adminPersonsEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.persons.edit',
    url : '/:personId/edit'
    templateUrl : require '../admin.persons.helper/admin.persons.helper.html'
    controller : 'AdminPersonsEditCtrl as vm'
    resolve :
      person : ['Person', '$stateParams', (Person, $stateParams) ->
        Person.getPerson $stateParams.personId
      ]

adminPersonsEditConfig.$inject = ['$stateProvider']

module.exports = adminPersonsEditConfig
