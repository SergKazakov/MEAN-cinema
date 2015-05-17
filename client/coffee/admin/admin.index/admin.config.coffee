adminConfig = ($stateProvider) ->
  $stateProvider.state 'admin',
    url : '/admin'
    absract : on
    templateUrl : require './admin.html'
    resolve :
      authenticated : ['$q', '$auth', '$rootScope', 'Auth', '$state', ($q, $auth, $rootScope, Auth, $state) ->
        deferred = $q.defer()
        if $rootScope.currentUser and $rootScope.currentUser.role is 'Admin'
          Auth
            .getProfile()
            .success (res) ->
              if res.role is 'Admin' then deferred.resolve()
              else $state.go 'home'
        else $state.go 'home'
        deferred.promise
      ]

adminConfig.$inject = ['$stateProvider']

module.exports = adminConfig
