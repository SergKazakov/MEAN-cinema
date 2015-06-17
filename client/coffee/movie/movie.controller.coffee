MovieCtrl = (Movie, movie, reviews, sessions, $auth, $alert) ->
  @movie        = movie.data
  @sessions     = sessions.data
  @reviews      = reviews.data.items
  @totalReviews = reviews.data.count
  @noSessions   = unless @sessions.length then on else no

  @addReview = ->
    if $auth.isAuthenticated()
      Movie
        .addMovieReview @movie._id, @review
        .success (res) =>
          $alert content : 'Отзыв успешно добавлен'
          @reviews.unshift res
          ++@totalReviews
          @review = {}
        .error (err) ->  $alert content : err
    else $alert content : 'Только зарегистрированные пользователи могут оставлять отзыв'

  return

MovieCtrl.$inject = ['Movie', 'movie', 'reviews', 'sessions', '$auth', '$alert']

module.exports = MovieCtrl
