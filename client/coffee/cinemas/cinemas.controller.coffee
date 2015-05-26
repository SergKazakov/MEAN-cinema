CinemasCtrl = (cinemas) ->
  @cinemas    = cinemas.data
  @noCinemas  = unless @cinemas then on else no

  return

CinemasCtrl.$inject = ['cinemas']

module.exports = CinemasCtrl
