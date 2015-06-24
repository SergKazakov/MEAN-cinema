Session = ($http) ->
  getSessions : ->
    $http.get '/api/v1/sessions'
  getSessionsByPage : (pageNumber, pageSize) ->
    $http.get "/api/v1/sessions?page=#{pageNumber}&size=#{pageSize}"
  createSession : (session) ->
    $http.post '/api/v1/sessions', session
  getSession : (sessionId) ->
    $http.get "/api/v1/sessions/#{sessionId}"
  editSession : (session) ->
    $http.put "/api/v1/sessions/#{session._id}", session
  deleteSession : (sessionId) ->
    $http.delete "/api/v1/sessions/#{sessionId}"

Session.$inject = ['$http']

module.exports = Session
