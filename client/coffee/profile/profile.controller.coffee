ProfileCtrl = ($rootScope, $auth, $alert, Auth) ->
  @getProfile = ->
    Auth
      .getProfile()
      .success (response) =>
        @user = response
      .error (error) ->
        $alert
          content : error.message
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3

  @getProfile()

  @updateProfile = ->
    Auth
      .updateProfile
        displayName : @user.displayName
        email : @user.email
      .success (response) ->
        $rootScope.currentUser = response
        $alert
          content : 'Профиль обновлен'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3

  @link = (provider) ->
    $auth
      .link provider
      .then ->
        $alert
          content : "Вы успешно привязали #{provider}"
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
      .then =>
        @getProfile()
      .catch (response) ->
        $alert
          content : response.data.message
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3

  @unlink = (provider) ->
    $auth
      .unlink provider
      .then ->
        $alert
          content : "Вы успешно отвязали #{provider}"
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
      .then =>
        @getProfile()
      .catch (response) ->
        $alert
          content : if response.data then response.data.message else "Невозможно привязать #{provider}"
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3

  return

ProfileCtrl.$inject = ['$rootScope', '$auth', '$alert', 'Auth']

module.exports = ProfileCtrl
