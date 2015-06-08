adminPersonsEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.persons.edit',
    url : '/:personId/edit'
    template : require '../admin.persons.helper/admin.persons.helper.jade'
    controller : 'AdminPersonsEditCtrl as vm'
    resolve :
      person : ['Person', '$stateParams', (Person, $stateParams) ->
        Person.getPerson $stateParams.personId
      ]

adminPersonsEditConfig.$inject = ['$stateProvider']

module.exports = adminPersonsEditConfig
