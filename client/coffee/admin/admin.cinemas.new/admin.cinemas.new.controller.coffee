AdminCinemasNewCtrl = (Cinema, $alert, $state, Upload) ->

  @action = ->
    if @file and @file.length
      Upload
        .upload
          url : '/api/v1/cinemas'
          method : 'POST'
          fields :
            cinema : @cinema
          file : @file
        .success (res) ->
          $alert
            content : 'Cinema has been added'
            animation : 'fadeZoomFadeDown'
            type : 'material'
            duration : 3
          $state.go 'admin.cinemas'
    else
      $alert
        content : 'Poster is required!'
        animation : 'fadeZoomFadeDown'
        type : 'material'
        duration : 3

  return

AdminCinemasNewCtrl.$inject = ['Cinema', '$alert', '$state', 'Upload']

module.exports = AdminCinemasNewCtrl
