adminPersonsNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.persons.new',
    url : '/new'
    template : require '../admin.persons.helper/admin.persons.helper.html'
    controller : 'AdminPersonsNewCtrl as vm'

adminPersonsNewConfig.$inject = ['$stateProvider']

module.exports = adminPersonsNewConfig
