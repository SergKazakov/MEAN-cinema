AdminMoviesCtrl = (Movie) ->
  @noMovies = no

  Movie
    .getMovies()
    .success (res) =>
      @noMovies = on if not res.length
      @movies = res

  @deleteMovie = (movieId, index) ->
    Movie
      .deleteMovie movieId
      .success (res) =>
        @movies.splice index, 1

  return

AdminMoviesCtrl.$inject = ['Movie']

module.exports = AdminMoviesCtrl
