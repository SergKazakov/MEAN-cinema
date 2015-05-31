AdminCtrl = ($state) ->

  @state = $state

  @menu = [
    title : 'Фильмы'
    state : 'admin.movies.all'
    parent : 'admin.movies'
  ,
    title : 'Люди'
    state : 'admin.persons.all'
    parent : 'admin.persons'
  ,
    title : 'Кинотеатры'
    state : 'admin.cinemas.all'
    parent : 'admin.cinemas'
  ,
    title : 'Залы'
    state : 'admin.halls.all'
    parent : 'admin.halls'
  ,
    title : 'Сеансы'
    state : 'admin.sessions.all'
    parent : 'admin.sessions'
  ]

  return

AdminCtrl.$inject = ['$state']

module.exports = AdminCtrl
