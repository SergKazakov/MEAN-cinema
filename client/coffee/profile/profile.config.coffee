profileConfig = ($stateProvider) ->
  $stateProvider.state 'profile',
    url : '/profile'
    templateUrl : require './profile.html'
    controller : 'ProfileCtrl as vm'
    resolve :
      authenticated : ($q, $location, $auth) ->
        deferred = $q.defer()
        if not $auth.isAuthenticated() then $location.path '/login' else deferred.resolve()
        deferred.promise

module.exports = profileConfig
