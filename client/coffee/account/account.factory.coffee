Account = ($http) ->
  getProfile : ->
    $http.get '/api/v1/me'
  updateProfile : (profileData) ->
    $http.put '/api/v1/me', profileData

module.exports = Account