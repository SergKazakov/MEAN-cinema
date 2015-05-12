AdminPersonEditCtrl = (Person, $alert, $state, $stateParams) ->

  Person
    .getPerson $stateParams.personId
    .success (res) =>
      @person = res

  @editPerson = ->
    Person
      .editPerson @person
      .success (res) ->
        $alert
          content : 'Person has been edited'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
        $state.go 'admin.persons'

  return

module.exports = AdminPersonEditCtrl
