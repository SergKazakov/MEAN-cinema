do ->
  LoginCtrl = ($scope, $alert, $auth) ->
    $scope.login = ->
      $auth
        .login
          email : $scope.email
          password : $scope.password
        .then ->
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
    $scope.authenticate = (provider) ->
      $auth
        .authenticate provider
        .then ->
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

  angular
    .module 'cinema'
    .controller 'LoginCtrl',  LoginCtrl
