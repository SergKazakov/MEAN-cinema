PersonCtrl = (person) ->
  @person = person.data

  return

PersonCtrl.$inject = ['person']

module.exports = PersonCtrl
