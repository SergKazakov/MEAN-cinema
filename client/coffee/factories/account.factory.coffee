do ->
  Account = ($http) ->
    getProfile : ->
      $http.get '/api/v1/me'
    updateProfile : (profileData) ->
      $http.put '/api/v1/me', profileData

  angular
    .module 'cinema'
    .factory 'Account',  Account
