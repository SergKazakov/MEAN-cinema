do ->
  angular
    .module 'cinema', [
      'ui.router'
      'auth0'
      'angular-storage'
      'angular-jwt'
    ]
    .config ($urlRouterProvider, $locationProvider, authProvider, $httpProvider, jwtInterceptorProvider) ->
      $urlRouterProvider.otherwise '/'
      $locationProvider.html5Mode on

      authProvider.init
        domain:       'sergeykazakoff-test.auth0.com'
        clientID:     'XPQYEuy68HSlowXjeRJuA4xK9V8HaZdX'
        callbackURL:  location.href
        loginState:   'login'

      jwtInterceptorProvider.tokenGetter = (aiStorage) -> aiStorage.get 'token'
      $httpProvider.interceptors.push 'jwtInterceptor'

    .run ($rootScope, auth, aiStorage, jwtHelper, $state) ->

      $rootScope.$on '$locationChangeStart', ->
        if not auth.isAuthenticated
          token = aiStorage.get 'token'
          if token
            if not jwtHelper.isTokenExpired token
              auth.authenticate aiStorage.get('profile'), token
            else $state.go 'login'
