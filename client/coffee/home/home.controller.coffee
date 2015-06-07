HomeCtrl = (newMovies, upcomingMovies) ->

  @newMovies          = newMovies.data
  @upcomingMovies     = upcomingMovies.data
  @noNewMovies        = unless @newMovies.length then on else no
  @noUpcomingMovies   = unless @upcomingMovies.length then on else no

  return

HomeCtrl.$inject = ['newMovies', 'upcomingMovies']

module.exports = HomeCtrl
