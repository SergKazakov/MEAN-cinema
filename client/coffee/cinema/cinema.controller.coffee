CinemaCtrl = (cinema, sessions) ->
  @cinema     = cinema.data
  @sessions   = sessions.data
  @noSessions = unless @sessions.length then on else no

  return

CinemaCtrl.$inject = ['cinema', 'sessions']

module.exports = CinemaCtrl
