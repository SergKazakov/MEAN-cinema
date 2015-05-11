adminConfig = ($stateProvider) ->
  $stateProvider.state 'admin',
    url : '/admin'
    absract : on
    templateUrl : require './admin.html'
    resolve :
      authenticated : ($q, $location, $auth, $rootScope) ->
        deferred = $q.defer()
        if $rootScope.currentUser and $rootScope.currentUser.role is 'Admin'
          deferred.resolve()
        else $location.path '/login'
        deferred.promise

module.exports = adminConfig
