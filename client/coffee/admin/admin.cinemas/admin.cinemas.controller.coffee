AdminCinemasCtrl = (Cinema, cinemas) ->

  @cinemas      = cinemas.data.items
  @totalCinemas = cinemas.data.count
  @pageSize     = 10
  @noCinemas    = unless @cinemas.length then on else no
  @currentPage  = 1

  @changePage = (newPageNumber) ->
    Cinema
      .getCinemasByPage newPageNumber, @pageSize
      .success (res) =>
        @cinemas      = res.items
        @totalCinemas = res.count

  @deleteCinema = (cinemaId, index) ->
    Cinema
      .deleteCinema cinemaId
      .success (res) =>
        @cinemas.splice index, 1

  return

AdminCinemasCtrl.$inject = ['Cinema', 'cinemas']

module.exports = AdminCinemasCtrl
