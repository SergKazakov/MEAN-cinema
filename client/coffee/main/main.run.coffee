mainRun = ($rootScope, $auth, store) ->
  $rootScope.currentUser = store.get 'profile' if $auth.isAuthenticated()

module.exports = mainRun
