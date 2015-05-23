AdminPersonsCtrl = (Person, persons) ->

  @persons      = persons.data.items
  @totalPersons = persons.data.count
  @noPersons    = unless @persons then on else no
  @currentPage  = 1

  @changePage = (newPageNumber) ->
    Person
      .getPersonsByPage newPageNumber
      .success (res) =>
        @persons      = res.items
        @totalPersons = res.count

  @deletePerson = (personId, index) ->
    Person
      .deletePerson personId
      .success (res) =>
        @persons.splice index, 1

  return

AdminPersonsCtrl.$inject = ['Person', 'persons']

module.exports = AdminPersonsCtrl
