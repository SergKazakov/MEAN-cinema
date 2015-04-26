ProfileCtrl = ($auth, $alert, Account) ->
  @getProfile = ->
    Account
      .getProfile()
      .success (data) =>
        @user = data
      .error (error) ->
        $alert
          content : error.message
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3

  @getProfile()

  @updateProfile = ->
    Account
      .updateProfile
        displayName : @user.displayName
        email : @user.email
      .then -> $alert
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

module.exports = ProfileCtrl
