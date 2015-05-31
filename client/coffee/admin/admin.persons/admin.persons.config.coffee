adminPersonsConfig = ($stateProvider) ->
  $stateProvider.state 'admin.persons.all',
    url : ''
    templateUrl : require './admin.persons.html'
    controller : 'AdminPersonsCtrl as vm'
    resolve :
      persons : ['Person', (Person) ->
        Person.getPersonsByPage 1
      ]

adminPersonsConfig.$inject = ['$stateProvider']

module.exports = adminPersonsConfig
