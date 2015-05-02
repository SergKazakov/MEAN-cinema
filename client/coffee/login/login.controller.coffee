LoginCtrl = ($rootScope, Auth, $alert, $auth, store) ->
  @login = ->
    $auth
      .login
        email : @email
        password : @password
      .then (response) ->
        store.set 'profile', response.data.user
        $rootScope.currentUser = store.get 'profile'
        $alert
          content : 'You have successfully logged in'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
      .catch (response) ->
        $alert
          content : response.data.message
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3

  @authenticate = (provider) ->
    $auth
      .authenticate provider
      .then (response) ->
        store.set 'profile', response.data.user
        $rootScope.currentUser = store.get 'profile'
        $alert
          content : 'You have successfully logged in'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
      .catch (response) ->
        $alert
          content : if response.data then response.data.message else response
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3

  return

module.exports = LoginCtrl
