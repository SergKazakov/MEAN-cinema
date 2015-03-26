do ->
  HomeCtrl = ($state, auth, store) ->
    @auth = auth

    @logout = ->
      auth.signout()
      store.remove 'profile'
      store.remove 'token'
      $state.go 'login'

    return

  angular
    .module 'cinema'
    .controller 'HomeCtrl',  HomeCtrl
