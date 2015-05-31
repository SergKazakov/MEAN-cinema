AdminHallsNewCtrl = (Hall, Cinema, $alert, $state) ->

  @action = ->
    Hall
      .createHall @hall
      .success (res) ->
        $alert
          content : 'Зал добавлен'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
        $state.go 'admin.halls.all'

  @loadCinemas = (name) ->
    Cinema
      .getCinemasByName name
      .then (res) => @cinemas = res.data

  return

AdminHallsNewCtrl.$inject = ['Hall', 'Cinema', '$alert', '$state']

module.exports = AdminHallsNewCtrl
