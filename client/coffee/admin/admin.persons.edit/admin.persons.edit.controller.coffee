AdminPersonsEditCtrl = (Person, person, $alert, $state, Upload) ->

  @person = person.data

  @action = ->
    if @file and @file.length
      promise = Upload.upload
        url : "/api/v1/persons/#{@person._id}"
        method : 'PUT'
        fields :
          person : @person
        file : @file
    else
      promise = Person.editPerson @person

    promise.success (res) ->
      $alert content : 'Изменения сохранены'
      $state.go 'admin.persons.all'

  @deletePerson = ->
    Person
      .deletePerson @person._id
      .success (res) ->
        $alert content : 'Человек успешно удален'
        $state.go 'admin.persons.all'
      .error (err) -> $alert content : err

  return

AdminPersonsEditCtrl.$inject = ['Person', 'person', '$alert', '$state', 'Upload']

module.exports = AdminPersonsEditCtrl
