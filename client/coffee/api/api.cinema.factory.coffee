Cinema = ($http) ->
  getCinemas : ->
    $http.get '/api/v1/cinemas'
  getCinemasByName : (cinemaName) ->
    $http.get "/api/v1/cinemas?name=#{cinemaName}"
  getCinemasByPage : (pageNumber) ->
    $http.get "/api/v1/cinemas?page=#{pageNumber}"
  createCinema : (cinema) ->
    $http.post '/api/v1/cinemas', cinema
  getCinema : (cinemaId) ->
    $http.get "/api/v1/cinemas/#{cinemaId}"
  editCinema : (cinema) ->
    $http.put "/api/v1/cinemas/#{cinema._id}", cinema
  deleteCinema : (cinemaId) ->
    $http.delete "/api/v1/cinemas/#{cinemaId}"

Cinema.$inject = ['$http']

module.exports = Cinema
