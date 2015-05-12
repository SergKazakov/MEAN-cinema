AdminPersonsNewCtrl = (Person, $alert, $state) ->

  @addPerson = ->
    Person
      .createPerson @person
      .success (res) ->
        $alert
          content : 'Person has been added'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
        $state.go 'admin.persons'

  return

module.exports = AdminPersonsNewCtrl
