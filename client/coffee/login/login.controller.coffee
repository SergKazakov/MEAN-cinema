LoginCtrl = ($rootScope, $alert, $auth, jwtHelper) ->
  @login = ->
    $auth
      .login
        email : @email
        password : @password
      .then (response) ->
        $rootScope.currentUser = jwtHelper.decodeToken(response.data.token).sub
        $alert content : 'Вы успешно вошли'
      .catch (response) ->
        $alert content : response.data.message

  @authenticate = (provider) ->
    $auth
      .authenticate provider
      .then (response) ->
        $rootScope.currentUser = jwtHelper.decodeToken(response.data.token).sub
        $alert content : 'Вы успешно вошли'
      .catch (response) ->
        $alert content : if response.data then response.data.message else response

  return

LoginCtrl.$inject = ['$rootScope', '$alert', '$auth', 'jwtHelper']

module.exports = LoginCtrl
