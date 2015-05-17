AdminCinemaEditCtrl = (Cinema, $alert, $state, $stateParams, Upload) ->

  Cinema
    .getCinema $stateParams.cinemaId
    .success (res) =>
      @cinema = res

  @editCinema = ->
    if @file and @file.length
      promise = Upload.upload
        url : "/api/v1/cinema/#{@cinema._id}"
        method : 'PUT'
        fields :
          cinema : @cinema
        file : @file
    else
      promise = Cinema.editCinema @cinema
    promise.success (res) ->
      $alert
        content : 'Cinema has been added'
        animation : 'fadeZoomFadeDown'
        type : 'material'
        duration : 3
      $state.go 'admin.cinemas'

  return

AdminCinemaEditCtrl.$inject = ['Cinema', '$alert', '$state', '$stateParams', 'Upload']

module.exports = AdminCinemaEditCtrl
