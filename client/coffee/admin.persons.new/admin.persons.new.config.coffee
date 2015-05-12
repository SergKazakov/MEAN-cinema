adminPersonsNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.personsnew',
    url : '/persons/new'
    templateUrl : require './admin.persons.new.html'
    controller : 'AdminPersonsNewCtrl as vm'

module.exports = adminPersonsNewConfig
