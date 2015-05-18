adminPersonEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.personedit',
    url : '/person/:personId/edit'
    templateUrl : require './admin.person.edit.html'
    controller : 'AdminPersonEditCtrl as vm'
    resolve :
      person : ['Person', '$stateParams', (Person, $stateParams) ->
        Person.getPerson $stateParams.personId
      ]

adminPersonEditConfig.$inject = ['$stateProvider']

module.exports = adminPersonEditConfig
