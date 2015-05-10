adminConfig = ($stateProvider) ->
  $stateProvider.state 'admin',
    url : '/admin'
    absract : on
    templateUrl : 'partials/admin'
    resolve :
      authenticated : ($q, $location, $auth, $rootScope) ->
        deferred = $q.defer()
        if $rootScope.currentUser and $rootScope.currentUser.role is 'Admin'
          deferred.resolve()
        else $location.path '/login'
        deferred.promise

module.exports = adminConfig
