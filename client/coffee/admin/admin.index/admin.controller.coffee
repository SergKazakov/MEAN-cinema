AdminCtrl = ->
  @menu = [
    title : 'Movies'
    state : 'admin.movies'
  ,
    title : 'Persons'
    state : 'admin.persons'
  ,
    title : 'Cinemas'
    state : 'admin.cinemas'
  ]

  return

module.exports = AdminCtrl
