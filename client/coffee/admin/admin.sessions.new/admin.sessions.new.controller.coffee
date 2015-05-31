AdminSessionsNewCtrl = (Session, Movie, $alert, $state) ->

  @format = ['2D', '3D', 'IMAX 2D', 'IMAX 3D']

  @action = ->
    Session
      .createSession @session
      .success (res) ->
        $alert
          content : 'Session has been added'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
        $state.go 'admin.sessions'

  @loadMovies = (name) ->
    Movie
      .getMoviesByName name
      .then (res) -> res.data

  return

AdminSessionsNewCtrl.$inject = ['Session', 'Movie', '$alert', '$state']

module.exports = AdminSessionsNewCtrl
