adminHallsNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.hallsnew',
    url : '/halls/new'
    templateUrl : require '../admin.halls.helper/admin.halls.helper.html'
    controller : 'AdminHallsNewCtrl as vm'

adminHallsNewConfig.$inject = ['$stateProvider']

module.exports = adminHallsNewConfig
