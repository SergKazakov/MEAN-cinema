personConfig = ($stateProvider) ->
  $stateProvider.state 'person',
    url : '/person/:personId'
    template : require './person.html'
    controller : 'PersonCtrl as vm'
    resolve :
      person : ['Person', '$stateParams', (Person, $stateParams) ->
        Person.getPerson $stateParams.personId
      ]

personConfig.$inject = ['$stateProvider']

module.exports = personConfig
