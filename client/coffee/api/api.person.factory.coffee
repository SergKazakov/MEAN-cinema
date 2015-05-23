Person = ($http) ->
  getPersons : ->
    $http.get '/api/v1/persons'
  createPerson : (person) ->
    $http.post '/api/v1/persons', person
  getPerson : (personId) ->
    $http.get "/api/v1/person/#{personId}"
  getPersonsByName : (personName) ->
    $http.get "/api/v1/persons?name=#{personName}"
  getPersonsByPage : (pageNumber) ->
    $http.get "/api/v1/persons?page=#{pageNumber}"
  editPerson : (person) ->
    $http.put "/api/v1/person/#{person._id}", person
  deletePerson : (personId) ->
    $http.delete "/api/v1/person/#{personId}"

Person.$inject = ['$http']

module.exports = Person
