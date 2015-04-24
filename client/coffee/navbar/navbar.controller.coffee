NavbarCtrl = ($auth, $alert) ->
  @isAuthenticated = -> $auth.isAuthenticated()

  @logout = (e) ->
    e.preventDefault()
    $auth
      .logout()
      .then ->
        $alert
          content : 'You have been logged out'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3

  return

module.exports = NavbarCtrl
