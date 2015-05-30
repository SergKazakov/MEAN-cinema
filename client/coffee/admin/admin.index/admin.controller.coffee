AdminCtrl = ->
  @menu = [
    title : 'Фильмы'
    state : 'admin.movies'
  ,
    title : 'Люди'
    state : 'admin.persons'
  ,
    title : 'Кинотеатры'
    state : 'admin.cinemas'
  ]

  return

module.exports = AdminCtrl
