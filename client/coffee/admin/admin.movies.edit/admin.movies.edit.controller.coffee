_ = require 'lodash'

AdminMoviesEditCtrl = (Movie, Person, movie, reviews, $alert, $state, Upload) ->

  @movie        = movie.data
  @reviews      = reviews.data.items
  @pageSize     = 5
  @currentPage  = 1

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

  @deleteReview = (movieId, reviewId) ->
    Movie
      .deleteMovieReview movieId, reviewId
      .success (res) =>
        $alert content : 'Отзыв успешно удален'
        index = _.findIndex @reviews, _id : reviewId
        @reviews.splice index, 1
      .error (err) -> $alert content : err

  @deleteMovie = ->
    Movie
      .deleteMovie @movie._id
      .success (res) ->
        $alert content : 'Фильм успешно удален'
        $state.go 'admin.movies.all'
      .error (err) -> $alert content : err

  return

AdminMoviesEditCtrl.$inject = ['Movie', 'Person', 'movie', 'reviews', '$alert', '$state', 'Upload']

module.exports = AdminMoviesEditCtrl
