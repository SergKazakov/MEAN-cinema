navbarDirective = ->
  restrict : 'E'
  template : require './navbar.html'
  controller : 'NavbarCtrl as vm'
  replace : on

module.exports = navbarDirective
