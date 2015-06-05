adminHallsConfig = ($stateProvider) ->
  $stateProvider.state 'admin.halls.all',
    url : ''
    template : require './admin.halls.html'
    controller : 'AdminHallsCtrl as vm'
    resolve :
      halls : ['Hall', (Hall) ->
        Hall.getHallsByPage 1
      ]

adminHallsConfig.$inject = ['$stateProvider']

module.exports = adminHallsConfig
