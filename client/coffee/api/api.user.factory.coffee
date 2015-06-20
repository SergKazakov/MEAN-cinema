User = ($http) ->
  getUsers : ->
    $http.get '/api/v1/users'
  getUsersByPage : (pageNumber, pageSize) ->
    $http.get "/api/v1/users?page=#{pageNumber}&size=#{pageSize}"
  deleteUser : (userId) ->
    $http.delete "/api/v1/users/#{userId}"

User.$inject = ['$http']

module.exports = User
