adminPersonsConfig = ($stateProvider) ->
  $stateProvider.state 'admin.persons',
    url : '/persons'
    abstract : on
    template : '<ui-view></ui-view>'

adminPersonsConfig.$inject = ['$stateProvider']

module.exports = adminPersonsConfig
