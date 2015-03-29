do ->
  authFactory = ($state, auth, store, $alert) ->
    login: ->
      auth.signin
        socialBigButtons: on
        authParams:
          scope: 'openid offline_access'
      , ->
          $alert
            content: 'Вы успешно вошли в свою учетную запись'
            type: 'success'
            duration: 2


    logout: ->
      auth.signout()
      store.remove 'profile'
      store.remove 'token'
      $state.go 'home'
      $alert
        content: 'Вы вышли из учетной записи'
        type: 'success'
        duration: 2

  angular
    .module 'cinema'
    .factory 'authFactory',  authFactory
