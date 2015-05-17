profileConfig = ($stateProvider) ->
  $stateProvider.state 'profile',
    url : '/profile'
    templateUrl : require './profile.html'
    controller : 'ProfileCtrl as vm'
    resolve :
      authenticated : ['$q', '$location', '$auth', ($q, $location, $auth) ->
        deferred = $q.defer()
        if not $auth.isAuthenticated() then $location.path '/login' else deferred.resolve()
        deferred.promise
      ]

profileConfig.$inject = ['$stateProvider']

module.exports = profileConfig
