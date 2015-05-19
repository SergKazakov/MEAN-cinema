adminCinema = ->
  restrict : 'E'
  scope :
    cinema : '='
    file : '='
    action : '&'
  templateUrl : require './admin.cinema.helper.html'

module.exports = adminCinema
