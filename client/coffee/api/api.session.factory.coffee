Session = ($http) ->
  getSessions : ->
    $http.get '/api/v1/sessions'
  getSessionsByPage : (pageNumber) ->
    $http.get "/api/v1/sessions?page=#{pageNumber}"
  getSessionsByCinema : (cinemaId) ->
    $http.get "/api/v1/sessions?cinema=#{cinemaId}"
  getSessionsByMovie : (movieId) ->
    $http.get "/api/v1/sessions?movie=#{movieId}"
  createSession : (session) ->
    $http.post '/api/v1/sessions', session
  getSession : (sessionId) ->
    $http.get "/api/v1/session/#{sessionId}"
  editSession : (session) ->
    $http.put "/api/v1/session/#{session._id}", session
  deleteSession : (sessionId) ->
    $http.delete "/api/v1/session/#{sessionId}"

Session.$inject = ['$http']

module.exports = Session
