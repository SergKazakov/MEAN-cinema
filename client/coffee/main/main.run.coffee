mainRun = ($rootScope, $auth, Permission, $q, Auth, jwtHelper, storage) ->
  if $auth.isAuthenticated()
    $rootScope.currentUser = jwtHelper.decodeToken(storage.get 'satellizer_token').sub

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

mainRun.$inject = ['$rootScope', '$auth', 'Permission', '$q', 'Auth', 'jwtHelper', 'satellizer.storage']

module.exports = mainRun
