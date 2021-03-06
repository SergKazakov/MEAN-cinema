SignupCtrl = ($rootScope, $alert, $auth, jwtHelper) ->
  @signup = ->
    $auth
      .signup
        displayName : @displayName
        email : @email
        password : @password
      .then (response) ->
        $rootScope.currentUser = jwtHelper.decodeToken(response.data.token).sub
      .catch (response) ->
        if typeof response.data.message is 'object'
          angular.forEach response.data.message, (message) ->
            $alert content : message[0]
        else
          $alert content : response.data.message

  return

SignupCtrl.$inject = ['$rootScope', '$alert', '$auth', 'jwtHelper']

module.exports = SignupCtrl
