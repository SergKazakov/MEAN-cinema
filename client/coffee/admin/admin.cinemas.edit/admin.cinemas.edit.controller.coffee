_ = require 'lodash'

AdminCinemasEditCtrl = (Cinema, cinema, reviews, $alert, $state, Upload) ->

  @cinema       = cinema.data
  @reviews      = reviews.data.items
  @pageSize     = 5
  @currentPage  = 1

  @action = ->
    if @file and @file.length
      promise = Upload.upload
        url : "/api/v1/cinemas/#{@cinema._id}"
        method : 'PUT'
        fields :
          cinema : @cinema
        file : @file
    else
      promise = Cinema.editCinema @cinema
    promise.success (res) ->
      $alert content : 'Кинотеатр добавлен'
      $state.go 'admin.cinemas.all'

  @deleteReview = (cinemaId, reviewId) ->
    Cinema
      .deleteCinemaReview cinemaId, reviewId
      .success (res) =>
        $alert content : 'Отзыв успешно удален'
        index = _.findIndex @reviews, _id : reviewId
        @reviews.splice index, 1
      .error (err) -> $alert content : err

  return

AdminCinemasEditCtrl.$inject = ['Cinema', 'cinema', 'reviews', '$alert', '$state', 'Upload']

module.exports = AdminCinemasEditCtrl
