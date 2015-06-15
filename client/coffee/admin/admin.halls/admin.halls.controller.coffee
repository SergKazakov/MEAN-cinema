AdminHallsCtrl = (Hall, halls) ->

  @halls      = halls.data.items
  @totalHalls = halls.data.count
  @pageSize   = 10
  @noHalls    = unless @halls.length then on else no
  @currentPage = 1

  @changePage = (newPageNumber) ->
    Hall
      .getHallsByPage newPageNumber, @pageSize
      .success (res) =>
        @halls      = res.items
        @totalHalls = res.count

  @deleteHall = (hallId, index) ->
    Hall
      .deleteHall hallId
      .success (res) =>
        @halls.splice index, 1
        --@totalHalls

  return

AdminHallsCtrl.$inject = ['Hall', 'halls']

module.exports = AdminHallsCtrl
