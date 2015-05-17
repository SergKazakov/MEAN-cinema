Cinema = ($http) ->
  getCinemas : ->
    $http.get '/api/v1/cinemas'
  createCinema : (cinema) ->
    $http.post '/api/v1/cinemas', cinema
  getCinema : (cinemaId) ->
    $http.get "/api/v1/cinema/#{cinemaId}"
  editCinema : (cinema) ->
    $http.put "/api/v1/cinema/#{cinema._id}", cinema
  deleteCinema : (cinemaId) ->
    $http.delete "/api/v1/cinema/#{cinemaId}"

Cinema.$inject = ['$http']

module.exports = Cinema
