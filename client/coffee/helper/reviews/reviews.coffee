reviewsDirective = ->
  restrict : 'E'
  template : require './reviews.jade'
  scope :
    model : '='
    review : '='
    action : '&'

module.exports = reviewsDirective
