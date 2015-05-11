AdminMoviesNewCtrl = (Movie, $alert, $state) ->

  @addMovie = ->
    Movie
      .createMovie @movie
      .success (res) ->
        $alert
          content : 'Movie has been added'
          animation : 'fadeZoomFadeDown'
          type : 'material'
          duration : 3
        $state.go 'admin.movies'

  return

module.exports = AdminMoviesNewCtrl
