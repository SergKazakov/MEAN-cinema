ProfileCtrl = ($rootScope, $auth, $alert, Auth, jwtHelper) ->
  @getProfile = ->
    Auth
      .getProfile()
      .success (response) => @user = response
      .error (error) -> $alert content : error.message

  @getProfile()

  @updateProfile = ->
    Auth
      .updateProfile
        displayName : @user.displayName
        email : @user.email
      .success (response) ->
        $rootScope.currentUser = jwtHelper.decodeToken(response.token).sub
        $auth.setToken response.token, redirect : no
        $alert content : 'Профиль обновлен'

  @link = (provider) ->
    $auth
      .link provider
      .then -> $alert content : "Вы успешно привязали #{provider}"
      .then => @getProfile()
      .catch (response) -> $alert content : response.data.message

  @unlink = (provider) ->
    $auth
      .unlink provider
      .then -> $alert content : "Вы успешно отвязали #{provider}"
      .then => @getProfile()
      .catch (response) ->
        $alert content : if response.data then response.data.message else "Невозможно привязать #{provider}"

  return

ProfileCtrl.$inject = ['$rootScope', '$auth', '$alert', 'Auth', 'jwtHelper']

module.exports = ProfileCtrl
