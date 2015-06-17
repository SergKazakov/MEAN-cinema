MovieCtrl = (Movie, movie, reviews, sessions, $auth, $alert) ->
  @movie        = movie.data
  @sessions     = sessions.data
  @noSessions   = unless @sessions.length then on else no
  @reviews      = reviews.data.items
  @totalReviews = reviews.data.count
  @pageSize     = 5
  @currentPage  = 1

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

  @changePage = (newPageNumber) ->
    Movie
      .getMovieReviewsByPage @movie._id, newPageNumber, @pageSize
      .success (res) =>
        @reviews      = res.items
        @totalReviews = res.count

  return

MovieCtrl.$inject = ['Movie', 'movie', 'reviews', 'sessions', '$auth', '$alert']

module.exports = MovieCtrl
