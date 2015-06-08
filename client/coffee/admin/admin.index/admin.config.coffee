adminConfig = ($stateProvider, tagsInputConfigProvider) ->
  $stateProvider.state 'admin',
    url : '/admin'
    absract : on
    template : require './admin.jade'
    controller : 'AdminCtrl as vm'
    data :
      permissions :
        only : ['admin']

  tagsInputConfigProvider.setDefaults 'tagsInput', addOnComma : no

adminConfig.$inject = ['$stateProvider', 'tagsInputConfigProvider']

module.exports = adminConfig
