do ->
  ProfileCtrl = ($scope, $auth, $alert, Account) ->
    $scope.getProfile = ->
      Account
        .getProfile()
        .success (data) ->
          $scope.user = data
        .error (error) ->
          $alert
            content : error.message
            animation : 'fadeZoomFadeDown'
            type : 'material'
            duration : 3

    $scope.getProfile()

    $scope.updateProfile = ->
      Account
        .updateProfile
          displayName : $scope.user.displayName
          email : $scope.user.email
        .then ->
        $alert
          content : 'Profile has been updated'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3

    $scope.link = (provider) ->
      $auth
        .link provider
        .then ->
          $alert
            content : 'You have successfully linked ' + provider + ' account'
            animation : 'fadeZoomFadeDown'
            type : 'material'
            duration : 3
        .then ->
          $scope.getProfile()
        .catch (response) ->
          $alert
            content : response.data.message
            animation : 'fadeZoomFadeDown'
            type : 'material'
            duration : 3

    $scope.unlink = (provider) ->
      $auth
        .unlink provider
        .then ->
          $alert
            content : 'You have successfully unlinked ' + provider + ' account'
            animation : 'fadeZoomFadeDown'
            type : 'material'
            duration : 3
        .then ->
          $scope.getProfile()
        .catch (response) ->
          $alert
            content : if response.data then response.data.message else 'Could not unlink ' + provider + ' account'
            animation : 'fadeZoomFadeDown'
            type : 'material'
            duration : 3

    return

  angular
    .module 'cinema'
    .controller 'ProfileCtrl',  ProfileCtrl
