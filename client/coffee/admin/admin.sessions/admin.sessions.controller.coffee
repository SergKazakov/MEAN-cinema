AdminSessionsCtrl = (Session, sessions) ->

  @sessions      = sessions.data.items
  @totalSessions = sessions.data.count
  @pageSize      = 10
  @noSessions    = unless @sessions.length then on else no
  @currentPage   = 1

  @changePage = (newPageNumber) ->
    Session
      .getSessionsByPage newPageNumber, @pageSize
      .success (res) =>
        @sessions      = res.items
        @totalSessions = res.count

  @deleteSession = (sessionId, index) ->
    Session
      .deleteSession sessionId
      .success (res) =>
        @sessions.splice index, 1
        --@totalSessions

  return

AdminSessionsCtrl.$inject = ['Session', 'sessions']

module.exports = AdminSessionsCtrl
