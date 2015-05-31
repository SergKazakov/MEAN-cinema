AdminMoviesNewCtrl = (Movie, Person, $alert, $state, Upload) ->

  @action = ->
    if @file and @file.length
      Upload
        .upload
          url : '/api/v1/movies'
          method : 'POST'
          fields :
            movie : @movie
          file : @file
        .success (res) ->
          $alert
            content : 'Фильм добавлен'
            animation : 'fadeZoomFadeDown'
            type : 'material'
            duration : 3
          $state.go 'admin.movies.all'
    else
      $alert
        content : 'Постер обязателен!'
        animation : 'fadeZoomFadeDown'
        type : 'material'
        duration : 3

  @loadPersons = (name) ->
    Person.getPersonsByName name

  return

AdminMoviesNewCtrl.$inject = ['Movie', 'Person', '$alert', '$state', 'Upload']

module.exports = AdminMoviesNewCtrl
