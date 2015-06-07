AdminHallsNewCtrl = (Hall, Cinema, $alert, $state) ->

  @action = ->
    Hall
      .createHall @hall
      .success (res) ->
        $alert content : 'Зал добавлен'
        $state.go 'admin.halls.all'

  @loadCinemas = (name) ->
    Cinema
      .getCinemasByName name
      .then (res) => @cinemas = res.data

  return

AdminHallsNewCtrl.$inject = ['Hall', 'Cinema', '$alert', '$state']

module.exports = AdminHallsNewCtrl
