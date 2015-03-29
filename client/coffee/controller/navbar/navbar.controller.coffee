do ->
  NavbarCtrl = ($state, auth, authFactory) ->
    @auth = auth

    @logout = (e) ->
      e.preventDefault()
      authFactory.logout()

    return

  angular
    .module 'cinema'
    .controller 'NavbarCtrl',  NavbarCtrl
