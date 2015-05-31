AdminMovieEditCtrl = (Movie, Person, movie, $alert, $state, Upload) ->

  @movie = movie.data

  @action = ->
    if @file and @file.length
      promise = Upload.upload
        url : "/api/v1/movie/#{@movie._id}"
        method : 'PUT'
        fields :
          movie : @movie
        file : @file
    else
      promise = Movie.editMovie @movie
    promise.success (res) ->
      $alert
        content : 'Movie has been added'
        animation : 'fadeZoomFadeDown'
        type : 'material'
        duration : 3
      $state.go 'admin.movies'

  @loadPersons = (name) ->
    Person.getPersonsByName name

  return

AdminMovieEditCtrl.$inject = ['Movie', 'Person', 'movie', '$alert', '$state', 'Upload']

module.exports = AdminMovieEditCtrl
