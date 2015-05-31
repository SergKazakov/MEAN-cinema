adminHallsNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.halls.new',
    url : '/new'
    templateUrl : require '../admin.halls.helper/admin.halls.helper.html'
    controller : 'AdminHallsNewCtrl as vm'

adminHallsNewConfig.$inject = ['$stateProvider']

module.exports = adminHallsNewConfig