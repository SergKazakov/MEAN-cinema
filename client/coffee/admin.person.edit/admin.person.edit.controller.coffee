AdminPersonEditCtrl = (Person, $alert, $state, $stateParams, Upload) ->

  Person
    .getPerson $stateParams.personId
    .success (res) =>
      @person = res

  @editPerson = ->
    if @file and @file.length
      promise = Upload.upload
        url : "/api/v1/person/#{@person._id}"
        method : 'PUT'
        fields :
          person : @person
        file : @file
    else
      promise = Person.editPerson @person

    promise.success (res) ->
      $alert
        content : 'Person has been added'
        animation : 'fadeZoomFadeDown'
        type : 'material'
        duration : 3
      $state.go 'admin.persons'

  return

module.exports = AdminPersonEditCtrl
