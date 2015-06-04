Person = ($http) ->
  getPersons : ->
    $http.get '/api/v1/persons'
  getPersonsByName : (personName) ->
    $http.get "/api/v1/persons?name=#{personName}"
  getPersonsByPage : (pageNumber) ->
    $http.get "/api/v1/persons?page=#{pageNumber}"
  createPerson : (person) ->
    $http.post '/api/v1/persons', person
  getPerson : (personId) ->
    $http.get "/api/v1/persons/#{personId}"
  editPerson : (person) ->
    $http.put "/api/v1/persons/#{person._id}", person
  deletePerson : (personId) ->
    $http.delete "/api/v1/persons/#{personId}"

Person.$inject = ['$http']

module.exports = Person
