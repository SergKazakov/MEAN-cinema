AdminPersonsNewCtrl = ($alert, $state, Upload) ->

  @action = ->
    if @file and @file.length
      Upload
        .upload
          url : '/api/v1/persons'
          method : 'POST'
          fields :
            person : @person
          file : @file
        .success (res) ->
          $alert
            content : 'Актер добавлен'
            animation : 'fadeZoomFadeDown'
            type : 'material'
            duration : 3
          $state.go 'admin.persons.all'
    else
      $alert
        content : 'Фото обязательно!'
        animation : 'fadeZoomFadeDown'
        type : 'material'
        duration : 3

  return

AdminPersonsNewCtrl.$inject = ['$alert', '$state', 'Upload']

module.exports = AdminPersonsNewCtrl
