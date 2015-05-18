AdminMovieEditCtrl = (Movie, Person, movie, $alert, $state, $stateParams, Upload) ->

  @movie = movie.data

  @editMovie = ->
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

  @loadActors = (name) ->
    Person.getPersonByName name

  return

AdminMovieEditCtrl.$inject = ['Movie', 'Person', 'movie', '$alert', '$state', '$stateParams', 'Upload']

module.exports = AdminMovieEditCtrl
