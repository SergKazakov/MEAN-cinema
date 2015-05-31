AdminSessionEditCtrl = (Session, session, Cinema, Movie, $alert, $state) ->

  @session = session.data

  @format = ['2D', '3D', 'IMAX 2D', 'IMAX 3D']

  @action = ->
    Session
      .editSession @session
      .success (res) ->
        $alert
          content : 'Сеанс добавлен'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
        $state.go 'admin.sessions'

  @loadMovies = (name) ->
    Movie
      .getMoviesByName name
      .then (res) => @movies = res.data

  @loadCinemas = (name) ->
    Cinema
      .getCinemasByName name
      .then (res) => @cinemas = res.data

  return

AdminSessionEditCtrl.$inject = ['Session', 'session', 'Cinema', 'Movie', '$alert', '$state']

module.exports = AdminSessionEditCtrl
