CinemaCtrl = (Cinema, cinema, sessions, $auth, $alert) ->
  @cinema     = cinema.data
  @sessions   = sessions.data
  @noSessions = unless @sessions.length then on else no

  @addReview = ->
    if $auth.isAuthenticated()
      Cinema
        .addCinemaReview @cinema._id, @review
        .success (res) =>
          $alert content : 'Отзыв успешно добавлен'
          @cinema.reviews.push res
          @review = {}
        .error (err) ->  $alert content : err
    else $alert content : 'Только зарегистрированные пользователи могут оставлять отзыв'

  return

CinemaCtrl.$inject = ['Cinema', 'cinema', 'sessions', '$auth', '$alert']

module.exports = CinemaCtrl
