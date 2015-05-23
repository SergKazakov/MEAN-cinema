Movie = ($http) ->
  getMovies : ->
    $http.get '/api/v1/movies'
  getMoviesByStatus : (movieStatus) ->
    $http.get "/api/v1/movies?status=#{movieStatus}"
  getMoviesByPage : (pageNumber) ->
    $http.get "/api/v1/movies?page=#{pageNumber}"
  createMovie : (movie) ->
    $http.post '/api/v1/movies', movie
  getMovie : (movieId) ->
    $http.get "/api/v1/movie/#{movieId}"
  editMovie : (movie) ->
    $http.put "/api/v1/movie/#{movie._id}", movie
  deleteMovie : (movieId) ->
    $http.delete "/api/v1/movie/#{movieId}"

Movie.$inject = ['$http']

module.exports = Movie
