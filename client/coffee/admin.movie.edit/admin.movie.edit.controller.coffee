AdminMovieEditCtrl = (Movie, $alert, $state, $stateParams) ->

  Movie
    .getMovie $stateParams.movieId
    .success (res) =>
      @movie = res

  @editMovie = ->
    Movie
      .editMovie @movie
      .success (res) ->
        $alert
          content : 'Movie has been edited'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
        $state.go 'admin.movies'

  return

module.exports = AdminMovieEditCtrl
