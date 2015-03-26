do ->
  LoginCtrl = (auth) ->
    @login = ->
      auth.signin
        socialBigButtons: on
        authParams:
          scope: 'openid offline_access'

    return

  angular
    .module 'cinema'
    .controller 'LoginCtrl',  LoginCtrl
