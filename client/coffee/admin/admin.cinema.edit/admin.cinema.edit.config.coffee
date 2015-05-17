adminCinemaEditConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemaedit',
    url : '/cinema/:cinemaId/edit'
    templateUrl : require './admin.cinema.edit.html'
    controller : 'AdminCinemaEditCtrl as vm'

adminCinemaEditConfig.$inject = ['$stateProvider']

module.exports = adminCinemaEditConfig
