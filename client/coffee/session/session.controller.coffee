SessionCtrl = (session) ->
  @session = session.data

  return

SessionCtrl.$inject = ['session']

module.exports = SessionCtrl
