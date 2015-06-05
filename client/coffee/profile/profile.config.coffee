profileConfig = ($stateProvider) ->
  $stateProvider.state 'profile',
    url : '/profile'
    template : require './profile.html'
    controller : 'ProfileCtrl as vm'
    data :
      permissions :
        only : ['user']
        redirectTo : 'login'

profileConfig.$inject = ['$stateProvider']

module.exports = profileConfig
