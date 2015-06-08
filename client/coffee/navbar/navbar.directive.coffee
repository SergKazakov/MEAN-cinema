navbarDirective = ->
  restrict : 'E'
  template : require './navbar.jade'
  controller : 'NavbarCtrl as vm'
  replace : on

module.exports = navbarDirective
