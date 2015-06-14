Movie = ($http) ->
  getMovies : ->
    $http.get '/api/v1/movies'
  getMoviesByName : (movieName) ->
    $http.get "/api/v1/movies?name=#{movieName}"
  getMoviesByStatus : (status) ->
    $http.get "/api/v1/movies?status=#{status}"
  getMoviesByPage : (pageNumber, pageSize) ->
    $http.get "/api/v1/movies?page=#{pageNumber}&size=#{pageSize}"
  createMovie : (movie) ->
    $http.post '/api/v1/movies', movie
  getMovie : (movieId) ->
    $http.get "/api/v1/movies/#{movieId}"
  editMovie : (movie) ->
    $http.put "/api/v1/movies/#{movie._id}", movie
  deleteMovie : (movieId) ->
    $http.delete "/api/v1/movies/#{movieId}"

Movie.$inject = ['$http']

module.exports = Movie
