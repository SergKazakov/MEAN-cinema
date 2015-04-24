profileConfig = ($stateProvider) ->
  $stateProvider.state 'profile',
    url : '/profile'
    templateUrl : 'partials/profile'
    controller : 'ProfileCtrl'
    resolve :
      authenticated : ($q, $state, $auth) ->
        deferred = $q.defer()
        if not $auth.isAuthenticated() then $state.go 'login' else deferred.resolve()
        deferred.promise

module.exports = profileConfig