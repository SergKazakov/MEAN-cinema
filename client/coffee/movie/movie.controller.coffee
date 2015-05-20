MovieCtrl = (movie) ->
  @movie = movie.data

  return

MovieCtrl.$inject = ['movie']

module.exports = MovieCtrl
