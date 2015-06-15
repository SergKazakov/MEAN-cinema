AdminMoviesCtrl = (Movie, movies) ->

  @movies      = movies.data.items
  @totalMovies = movies.data.count
  @pageSize    = 10
  @noMovies    = unless @movies.length then on else no
  @currentPage = 1

  @changePage = (newPageNumber) ->
    Movie
      .getMoviesByPage newPageNumber, @pageSize
      .success (res) =>
        @movies      = res.items
        @totalMovies = res.count

  @deleteMovie = (movieId, index) ->
    Movie
      .deleteMovie movieId
      .success (res) =>
        @movies.splice index, 1
        --@totalMovies

  return

AdminMoviesCtrl.$inject = ['Movie', 'movies']

module.exports = AdminMoviesCtrl
