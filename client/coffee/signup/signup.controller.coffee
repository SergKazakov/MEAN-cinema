SignupCtrl = ($alert, $auth) ->
  @signup = ->
    $auth
      .signup
        displayName : @displayName
        email : @email
        password : @password
      .catch (response) ->
        if typeof response.data.message is 'object'
          angular.forEach response.data.message, (message) ->
            $alert
              content : message[0]
              animation : 'fadeZoomFadeDown'
              type : 'material'
              duration : 3
        else
          $alert
            content : response.data.message
            animation : 'fadeZoomFadeDown'
            type : 'material'
            duration : 3

  return

module.exports = SignupCtrl