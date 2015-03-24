do ->
  HomeCtrl = ($state, auth, aiStorage) ->
    @logout = ->
      auth.signout()
      aiStorage.remove 'profile'
      aiStorage.remove 'token'
      $state.go 'login'

    return

  angular
    .module 'cinema'
    .controller 'HomeCtrl',  HomeCtrl
