AdminCinemasEditCtrl = (Cinema, cinema, $alert, $state, Upload) ->

  @cinema = cinema.data

  @action = ->
    if @file and @file.length
      promise = Upload.upload
        url : "/api/v1/cinemas/#{@cinema._id}"
        method : 'PUT'
        fields :
          cinema : @cinema
        file : @file
    else
      promise = Cinema.editCinema @cinema
    promise.success (res) ->
      $alert
        content : 'Кинотеатр добавлен'
        animation : 'fadeZoomFadeDown'
        type : 'material'
        duration : 3
      $state.go 'admin.cinemas.all'

  return

AdminCinemasEditCtrl.$inject = ['Cinema', 'cinema', '$alert', '$state', 'Upload']

module.exports = AdminCinemasEditCtrl
