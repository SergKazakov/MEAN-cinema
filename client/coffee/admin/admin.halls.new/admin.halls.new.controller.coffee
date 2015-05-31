AdminHallsNewCtrl = (Hall, Cinema, $alert, $state) ->

  @action = ->
    Hall
      .createHall @hall
      .success (res) ->
        $alert
          content : 'Hall has been added'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
        $state.go 'admin.halls'

  @loadCinemas = (name) ->
    Cinema
      .getCinemasByName name
      .then (res) => @cinemas = res.data

  return

AdminHallsNewCtrl.$inject = ['Hall', 'Cinema', '$alert', '$state']

module.exports = AdminHallsNewCtrl
