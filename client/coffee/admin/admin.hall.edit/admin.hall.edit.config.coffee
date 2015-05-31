adminHallEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.halls.edit',
    url : '/:hallId/edit'
    templateUrl : require '../admin.halls.helper/admin.halls.helper.html'
    controller : 'AdminHallEditCtrl as vm'
    resolve :
      hall : ['Hall', '$stateParams', (Hall, $stateParams) ->
        Hall.getHall $stateParams.hallId
      ]

adminHallEditConfig.$inject = ['$stateProvider']

module.exports = adminHallEditConfig
