reviewsDirective = ->
  restrict : 'E'
  template : require './reviews.jade'
  scope :
    reviews : '='
    review : '='
    action : '&'

module.exports = reviewsDirective
