AdminPersonsCtrl = (Person) ->
  @noPersons = no

  Person
    .getPersons()
    .success (res) =>
      @noPersons = on if not res.length
      @persons = res

  @deletePerson = (personId, index) ->
    Person
      .deletePerson personId
      .success (res) =>
        @persons.splice index, 1

  return

AdminPersonsCtrl.$inject = ['Person']

module.exports = AdminPersonsCtrl
