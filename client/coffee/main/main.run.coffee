mainRun = ($rootScope, $auth, store) ->
  $rootScope.currentUser = store.get 'profile' if $auth.isAuthenticated()

mainRun.$inject = ['$rootScope', '$auth', 'store']

module.exports = mainRun
