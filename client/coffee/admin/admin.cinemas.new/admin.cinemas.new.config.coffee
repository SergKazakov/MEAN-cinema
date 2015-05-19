adminCinemasNewConfig = ($stateProvider) ->
  $stateProvider.state 'admin.cinemasnew',
    url : '/cinemas/new'
    template : '<admin-cinema action="vm.addCinema()" cinema="vm.cinema" file="vm.file"></admin-cinema>'
    controller : 'AdminCinemasNewCtrl as vm'

adminCinemasNewConfig.$inject = ['$stateProvider']

module.exports = adminCinemasNewConfig
