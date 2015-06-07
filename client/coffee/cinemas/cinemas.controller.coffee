CinemasCtrl = (cinemas) ->
  @cinemas    = cinemas.data
  @noCinemas  = unless @cinemas.length then on else no

  return

CinemasCtrl.$inject = ['cinemas']

module.exports = CinemasCtrl
