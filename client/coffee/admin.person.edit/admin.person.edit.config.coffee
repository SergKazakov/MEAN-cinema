adminPersonEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.personedit',
    url : '/person/:personId/edit'
    templateUrl : require './admin.person.edit.html'
    controller : 'AdminPersonEditCtrl as vm'

adminPersonEditConfig.$inject = ['$stateProvider']

module.exports = adminPersonEditConfig
