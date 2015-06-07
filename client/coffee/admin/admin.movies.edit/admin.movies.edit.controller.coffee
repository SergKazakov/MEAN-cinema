AdminMoviesEditCtrl = (Movie, Person, movie, $alert, $state, Upload) ->

  @movie = movie.data

  @action = ->
    if @file and @file.length
      promise = Upload.upload
        url : "/api/v1/movies/#{@movie._id}"
        method : 'PUT'
        fields :
          movie : @movie
        file : @file
    else
      promise = Movie.editMovie @movie
    promise.success (res) ->
      $alert content : 'Фильм добавлен'
      $state.go 'admin.movies.all'

  @loadPersons = (name) ->
    Person.getPersonsByName name

  return

AdminMoviesEditCtrl.$inject = ['Movie', 'Person', 'movie', '$alert', '$state', 'Upload']

module.exports = AdminMoviesEditCtrl
