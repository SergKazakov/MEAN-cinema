mainRun = ($rootScope, $auth, Permission, $q, Auth, jwtHelper) ->
  if $auth.isAuthenticated()
    $rootScope.currentUser = jwtHelper.decodeToken($auth.getToken()).sub

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

mainRun.$inject = ['$rootScope', '$auth', 'Permission', '$q', 'Auth', 'jwtHelper']

module.exports = mainRun
