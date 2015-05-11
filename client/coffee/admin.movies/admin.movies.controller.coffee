AdminMoviesCtrl = (Movie) ->
  @noMovies = no

  Movie
    .getMovies()
    .success (res) =>
      @noMovies = on if not res.length
      @movies = res

  return

module.exports = AdminMoviesCtrl
