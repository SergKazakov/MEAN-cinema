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
  ,
    title : 'Сеансы'
    state : 'admin.sessions'
  ]

  return

module.exports = AdminCtrl
