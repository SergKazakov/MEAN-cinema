NavbarCtrl = ($auth, $alert, Auth, $rootScope) ->
  @isAuthenticated = -> $auth.isAuthenticated()

  @logout = (e) ->
    e.preventDefault()
    $auth
      .logout()
      .then -> $alert content : 'Вы успешно вышли'

  return

NavbarCtrl.$inject = ['$auth', '$alert', 'Auth', '$rootScope']

module.exports = NavbarCtrl
