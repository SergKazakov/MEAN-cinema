AdminHallsEditCtrl = (Hall, hall, Cinema, $alert, $state) ->

  @hall = hall.data

  @action = ->
    Hall
      .editHall @hall
      .success (res) ->
        $alert content : 'Зал добавлен'
        $state.go 'admin.halls.all'

  @loadCinemas = (name) ->
    Cinema
      .getCinemasByName name
      .then (res) => @cinemas = res.data

  return

AdminHallsEditCtrl.$inject = ['Hall', 'hall', 'Cinema', '$alert', '$state']

module.exports = AdminHallsEditCtrl
