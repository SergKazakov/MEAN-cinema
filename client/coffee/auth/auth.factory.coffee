Auth = ($http, store) ->
  getProfile : ->
    $http.get '/api/v1/me'
  updateProfile : (profile) ->
    $http.put '/api/v1/me', profile

Auth.$inject = ['$http', 'store']

module.exports = Auth
