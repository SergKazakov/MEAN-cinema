_ = require 'lodash'

MovieCtrl = (Movie, movie, sessions, $auth, $alert) ->
  @movie      = movie.data
  @sessions   = sessions.data
  @noSessions = unless @sessions.length then on else no

  @addReview = ->
    if $auth.isAuthenticated()
      Movie
        .addMovieReview @movie._id, @review
        .success (res) =>
          $alert content : 'Отзыв успешно добавлен'
          @movie.reviews = res
          @review = {}
        .error (err) ->  $alert content : err
    else $alert content : 'Только зарегистрированные пользователи могут оставлять отзыв'

  return

MovieCtrl.$inject = ['Movie', 'movie', 'sessions', '$auth', '$alert']

module.exports = MovieCtrl
