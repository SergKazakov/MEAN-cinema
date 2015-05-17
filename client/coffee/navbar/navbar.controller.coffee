NavbarCtrl = ($auth, $alert, Auth, store, $rootScope) ->
  @isAuthenticated = -> $auth.isAuthenticated()

  @logout = (e) ->
    e.preventDefault()
    $auth
      .logout()
      .then ->
        store.remove 'profile'
        $alert
          content : 'You have been logged out'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3

  return

NavbarCtrl.$inject = ['$auth', '$alert', 'Auth', 'store', '$rootScope']

module.exports = NavbarCtrl
