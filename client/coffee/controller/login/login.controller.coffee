do ->
  LoginCtrl = ($state, auth, aiStorage) ->
    @login = ->
      auth.signin {}, (profile, token) ->
        aiStorage.set 'profile', profile
        aiStorage.set 'token', token
        $state.go 'home'
      , (error) ->
        console.log 'There was an error logging in', error

    return

  angular
    .module 'cinema'
    .controller 'LoginCtrl',  LoginCtrl
