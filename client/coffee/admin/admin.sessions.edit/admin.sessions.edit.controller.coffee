AdminSessionsEditCtrl = (Session, session, Cinema, Movie, $alert, $state) ->

  @session = session.data

  @format = ['2D', '3D', 'IMAX 2D', 'IMAX 3D']

  @action = ->
    Session
      .editSession @session
      .success (res) ->
        $alert content : 'Изменения сохранены'
        $state.go 'admin.sessions.all'

  @loadMovies = (name) ->
    Movie
      .getMoviesByName name
      .then (res) => @movies = res.data

  @loadCinemas = (name) ->
    Cinema
      .getCinemasByName name
      .then (res) => @cinemas = res.data

  @loadHalls = (item, model) ->
    @session.hall = if model.halls.length then model.halls[0] else ''

  return

AdminSessionsEditCtrl.$inject = ['Session', 'session', 'Cinema', 'Movie', '$alert', '$state']

module.exports = AdminSessionsEditCtrl
