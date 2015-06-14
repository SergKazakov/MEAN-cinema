ProfileCtrl = ($rootScope, $auth, $alert, Auth, jwtHelper, Upload) ->
  @getProfile = ->
    Auth
      .getProfile()
      .success (res) => @user = res
      .error (error) -> $alert content : error.message

  @getProfile()

  @updateProfile = ->
    if @file and @file.length
      promise = Upload.upload
        url : '/api/v1/me'
        method : 'PUT'
        fields :
          user : @user
        file : @file
    else promise = Auth.updateProfile @user
    promise.success (res) ->
      $rootScope.currentUser = jwtHelper.decodeToken(res.token).sub
      $auth.setToken res.token, redirect : no
      $alert content : 'Профиль обновлен'

  @link = (provider) ->
    $auth
      .link provider
      .then -> $alert content : "Вы успешно привязали #{provider}"
      .then => @getProfile()
      .catch (res) -> $alert content : res.data.message

  @unlink = (provider) ->
    $auth
      .unlink provider
      .then -> $alert content : "Вы успешно отвязали #{provider}"
      .then => @getProfile()
      .catch (res) ->
        $alert content : if res.data then res.data.message else "Невозможно привязать #{provider}"

  return

ProfileCtrl.$inject = ['$rootScope', '$auth', '$alert', 'Auth', 'jwtHelper', 'Upload']

module.exports = ProfileCtrl
