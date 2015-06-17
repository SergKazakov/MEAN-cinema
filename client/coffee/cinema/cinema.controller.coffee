CinemaCtrl = (Cinema, cinema, reviews, sessions, $auth, $alert) ->
  @cinema       = cinema.data
  @sessions     = sessions.data
  @noSessions   = unless @sessions.length then on else no
  @reviews      = reviews.data.items
  @totalReviews = reviews.data.count
  @pageSize     = 5
  @currentPage  = 1

  @addReview = ->
    if $auth.isAuthenticated()
      Cinema
        .addCinemaReview @cinema._id, @review
        .success (res) =>
          $alert content : 'Отзыв успешно добавлен'
          @reviews.unshift res
          ++@totalReviews
          @review = {}
        .error (err) ->  $alert content : err
    else $alert content : 'Только зарегистрированные пользователи могут оставлять отзыв'

  @changePage = (newPageNumber) ->
    Cinema
      .getCinemaReviewsByPage @cinema._id, newPageNumber, @pageSize
      .success (res) =>
        @reviews      = res.items
        @totalReviews = res.count

  return

CinemaCtrl.$inject = ['Cinema', 'cinema', 'reviews', 'sessions', '$auth', '$alert']

module.exports = CinemaCtrl
