Hall = ($http) ->
  getHalls : ->
    $http.get '/api/v1/halls'
  getHallsByPage : (pageNumber) ->
    $http.get "/api/v1/halls?page=#{pageNumber}"
  createHall : (hall) ->
    $http.post '/api/v1/halls', hall
  getHall : (hallId) ->
    $http.get "/api/v1/hall/#{hallId}"
  editHall : (hall) ->
    $http.put "/api/v1/hall/#{hall._id}", hall
  deleteHall : (hallId) ->
    $http.delete "/api/v1/hall/#{hallId}"

Hall.$inject = ['$http']

module.exports = Hall
