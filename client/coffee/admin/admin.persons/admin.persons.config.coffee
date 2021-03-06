adminPersonsConfig = ($stateProvider) ->
  $stateProvider.state 'admin.persons.all',
    url : ''
    template : require './admin.persons.jade'
    controller : 'AdminPersonsCtrl as vm'
    resolve :
      persons : ['Person', (Person) ->
        Person.getPersonsByPage 1, 10
      ]

adminPersonsConfig.$inject = ['$stateProvider']

module.exports = adminPersonsConfig
