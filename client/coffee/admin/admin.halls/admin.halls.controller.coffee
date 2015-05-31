AdminHallsCtrl = (Hall, halls) ->

  @halls      = halls.data.items
  @totalHalls = halls.data.count
  @noHalls    = unless @halls.length then on else no
  @currentPage = 1

  @changePage = (newPageNumber) ->
    Hall
      .getHallsByPage newPageNumber
      .success (res) =>
        @halls      = res.items
        @totalHalls = res.count

  @deleteHall = (hallId, index) ->
    Hall
      .deleteHall hallId
      .success (res) =>
        @halls.splice index, 1

  return

AdminHallsCtrl.$inject = ['Hall', 'halls']

module.exports = AdminHallsCtrl
