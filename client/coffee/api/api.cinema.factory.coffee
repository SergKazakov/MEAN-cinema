Cinema = ($http) ->
  getCinemas : ->
    $http.get '/api/v1/cinemas'
  getCinemasByName : (cinemaName) ->
    $http.get "/api/v1/cinemas?name=#{cinemaName}"
  getCinemasByPage : (pageNumber, pageSize) ->
    $http.get "/api/v1/cinemas?page=#{pageNumber}&size=#{pageSize}"
  createCinema : (cinema) ->
    $http.post '/api/v1/cinemas', cinema
  getCinema : (cinemaId) ->
    $http.get "/api/v1/cinemas/#{cinemaId}"
  editCinema : (cinema) ->
    $http.put "/api/v1/cinemas/#{cinema._id}", cinema
  deleteCinema : (cinemaId) ->
    $http.delete "/api/v1/cinemas/#{cinemaId}"
  addCinemaReview : (cinemaId, review) ->
    $http.post "/api/v1/cinemas/#{cinemaId}/reviews", review
  getCinemaReviews : (cinemaId) ->
    $http.get "/api/v1/cinemas/#{cinemaId}/reviews"
  getCinemaReviewsByPage : (cinemaId, pageNumber, pageSize) ->
    $http.get "/api/v1/cinemas/#{cinemaId}/reviews?page=#{pageNumber}&size=#{pageSize}"
  deleteCinemaReview : (cinemaId, reviewId) ->
    $http.delete "/api/v1/cinemas/#{cinemaId}/reviews/#{reviewId}"

Cinema.$inject = ['$http']

module.exports = Cinema
