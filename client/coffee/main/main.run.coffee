mainRun = ($rootScope, $auth, store, Permission, $q, Auth) ->
  $rootScope.currentUser = store.get 'profile' if $auth.isAuthenticated()

  Permission
    .defineRole 'user', (stateParams) ->
      Auth.getProfile()
    .defineRole 'admin', (stateParams) ->
      deferred = $q.defer()

      Auth.getProfile().then (res) ->
        if res.data.role is 'Admin' then deferred.resolve()
        else deferred.reject()
      , -> deferred.reject()

      deferred.promise

mainRun.$inject = ['$rootScope', '$auth', 'store', 'Permission', '$q', 'Auth']

module.exports = mainRun
