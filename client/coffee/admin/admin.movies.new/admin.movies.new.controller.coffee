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
            content : 'Movie has been added'
            animation : 'fadeZoomFadeDown'
            type : 'material'
            duration : 3
          $state.go 'admin.movies'
    else
      $alert
        content : 'Poster is required!'
        animation : 'fadeZoomFadeDown'
        type : 'material'
        duration : 3

  @loadActors = (name) ->
    Person.getPersonsByName name

  return

AdminMoviesNewCtrl.$inject = ['Movie', 'Person', '$alert', '$state', 'Upload']

module.exports = AdminMoviesNewCtrl
