CinemaCtrl = (Cinema, cinema, reviews, sessions, $auth, $alert) ->
  @cinema       = cinema.data
  @sessions     = sessions.data
  @reviews      = reviews.data.items
  @totalReviews = reviews.data.count
  @noSessions   = unless @sessions.length then on else no

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

  return

CinemaCtrl.$inject = ['Cinema', 'cinema', 'reviews', 'sessions', '$auth', '$alert']

module.exports = CinemaCtrl
