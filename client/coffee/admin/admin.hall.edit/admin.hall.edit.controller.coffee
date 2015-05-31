AdminHallEditCtrl = (Hall, hall, Cinema, $alert, $state) ->

  @hall = hall.data

  @action = ->
    Hall
      .editHall @hall
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

AdminHallEditCtrl.$inject = ['Hall', 'hall', 'Cinema', '$alert', '$state']

module.exports = AdminHallEditCtrl
