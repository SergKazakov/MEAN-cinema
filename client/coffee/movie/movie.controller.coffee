MovieCtrl = (movie, sessions) ->
  @movie      = movie.data
  @sessions   = sessions.data
  @noSessions = unless @sessions.length then on else no

  return

MovieCtrl.$inject = ['movie', 'sessions']

module.exports = MovieCtrl
