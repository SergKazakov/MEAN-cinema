NavbarCtrl = ($auth, $alert, Auth, $rootScope) ->
  @isAuthenticated = -> $auth.isAuthenticated()

  @logout = (e) ->
    e.preventDefault()
    $auth
      .logout()
      .then ->
        $rootScope.currentUser = {}
        $alert content : 'Вы успешно вышли'

  return

NavbarCtrl.$inject = ['$auth', '$alert', 'Auth', '$rootScope']

module.exports = NavbarCtrl
