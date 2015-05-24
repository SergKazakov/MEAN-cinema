HomeCtrl = (newMovies, upcomingMovies) ->

  @newMovies      = newMovies.data
  @upcomingMovies = upcomingMovies.data

  return

HomeCtrl.$inject = ['newMovies', 'upcomingMovies']

module.exports = HomeCtrl
