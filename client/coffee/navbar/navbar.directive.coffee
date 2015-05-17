navbarDirective = ->
  restrict : 'E'
  templateUrl : require './navbar.html'
  controller : 'NavbarCtrl as vm'
  replace : on

module.exports = navbarDirective
