CinemaCtrl = (cinema) ->
  @cinema     = cinema.data
  @noSessions = unless @cinema.sessions then on else no

  return

CinemaCtrl.$inject = ['cinema']

module.exports = CinemaCtrl
