adminHallsEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.halls.edit',
    url : '/:hallId/edit'
    template : require '../admin.halls.helper/admin.halls.helper.html'
    controller : 'AdminHallsEditCtrl as vm'
    resolve :
      hall : ['Hall', '$stateParams', (Hall, $stateParams) ->
        Hall.getHall $stateParams.hallId
      ]

adminHallsEditConfig.$inject = ['$stateProvider']

module.exports = adminHallsEditConfig
