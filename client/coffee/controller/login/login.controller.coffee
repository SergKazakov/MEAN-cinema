do ->
  LoginCtrl = (auth, authFactory) ->
    authFactory.login()

    return

  angular
    .module 'cinema'
    .controller 'LoginCtrl',  LoginCtrl
