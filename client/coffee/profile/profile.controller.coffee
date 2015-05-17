ProfileCtrl = ($rootScope, $auth, $alert, Auth, store) ->
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
        store.set 'profile', response
        $rootScope.currentUser = store.get 'profile'
        $alert
          content : 'Profile has been updated'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3

  @link = (provider) ->
    $auth
      .link provider
      .then ->
        $alert
          content : "You have successfully linked #{provider} account"
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
          content : "You have successfully unlinked #{provider} account"
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
      .then =>
        @getProfile()
      .catch (response) ->
        $alert
          content : if response.data then response.data.message else "Could not unlink #{provider} account"
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3

  return

ProfileCtrl.$inject = ['$rootScope', '$auth', '$alert', 'Auth', 'store']

module.exports = ProfileCtrl
