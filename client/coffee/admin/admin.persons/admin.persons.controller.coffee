AdminPersonsCtrl = (Person, persons) ->

  @persons      = persons.data.items
  @totalPersons = persons.data.count
  @pageSize     = 10
  @noPersons    = unless @persons.length then on else no
  @currentPage  = 1

  @changePage = (newPageNumber) ->
    Person
      .getPersonsByPage newPageNumber, @pageSize
      .success (res) =>
        @persons      = res.items
        @totalPersons = res.count

  return

AdminPersonsCtrl.$inject = ['Person', 'persons']

module.exports = AdminPersonsCtrl
