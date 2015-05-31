adminHallsConfig = ($stateProvider) ->
  $stateProvider.state 'admin.halls',
    url : '/halls'
    templateUrl : require './admin.halls.html'
    controller : 'AdminHallsCtrl as vm'
    resolve :
      halls : ['Hall', (Hall) ->
        Hall.getHallsByPage 1
      ]

adminHallsConfig.$inject = ['$stateProvider']

module.exports = adminHallsConfig
