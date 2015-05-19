HomeCtrl = (movies) ->

  @movies = movies.data

  return

HomeCtrl.$inject = ['movies']

module.exports = HomeCtrl
