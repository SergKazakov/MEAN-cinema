do ->
  ProfileCtrl = (auth) ->
    @auth = auth

    return

  angular
    .module 'cinema'
    .controller 'ProfileCtrl',  ProfileCtrl
