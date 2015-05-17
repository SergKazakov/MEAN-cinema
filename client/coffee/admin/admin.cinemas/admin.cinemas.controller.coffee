AdminCinemasCtrl = (Cinema) ->
  @noCinemas = no

  Cinema
    .getCinemas()
    .success (res) =>
      @noCinemas = on if not res.length
      @cinemas = res

  @deleteMovie = (cinemaId, index) ->
    Cinema
      .deleteMovie cinemaId
      .success (res) =>
        @cinemas.splice index, 1

  return

AdminCinemasCtrl.$inject = ['Cinema']

module.exports = AdminCinemasCtrl
