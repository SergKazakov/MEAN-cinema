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
            content : 'Кинотеатр добавлен'
            animation : 'fadeZoomFadeDown'
            type : 'material'
            duration : 3
          $state.go 'admin.cinemas.all'
    else
      $alert
        content : 'Постер обязателен!'
        animation : 'fadeZoomFadeDown'
        type : 'material'
        duration : 3

  return

AdminCinemasNewCtrl.$inject = ['Cinema', '$alert', '$state', 'Upload']

module.exports = AdminCinemasNewCtrl
