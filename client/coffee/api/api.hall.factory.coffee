Hall = ($http) ->
  getHalls : ->
    $http.get '/api/v1/halls'
  getHallsByPage : (pageNumber, pageSize) ->
    $http.get "/api/v1/halls?page=#{pageNumber}&size=#{pageSize}"
  createHall : (hall) ->
    $http.post '/api/v1/halls', hall
  getHall : (hallId) ->
    $http.get "/api/v1/halls/#{hallId}"
  editHall : (hall) ->
    $http.put "/api/v1/halls/#{hall._id}", hall
  deleteHall : (hallId) ->
    $http.delete "/api/v1/halls/#{hallId}"

Hall.$inject = ['$http']

module.exports = Hall
