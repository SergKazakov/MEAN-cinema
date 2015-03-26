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

      authProvider.init
        domain:       'sergeykazakoff-test.auth0.com'
        clientID:     'XPQYEuy68HSlowXjeRJuA4xK9V8HaZdX'
        loginState:   'login'

      authProvider.on 'loginSuccess', ($state, profilePromise, idToken, refreshToken, store) ->
        $state.go 'home'
        store.set 'token', idToken
        store.set 'refreshToken', refreshToken
        profilePromise.then (profile) ->
          store.set 'profile', profile

      authProvider.on 'loginFailure', ($log, error) ->
        $log 'Error logging in', error

      jwtInterceptorProvider.tokenGetter = (store, jwtHelper, auth) ->
        idToken = store.get 'token'
        refreshToken = store.get 'refreshToken'
        if not idToken or not refreshToken then return null
        if jwtHelper.isTokenExpired idToken
          auth
            .refreshIdToken refreshToken
            .then (idToken) ->
              store.set 'token', idToken
              idToken
        else
          idToken

      $httpProvider.interceptors.push 'jwtInterceptor'

    .run ($rootScope, auth, store, jwtHelper, $state) ->

      $rootScope.$on '$locationChangeStart', ->
        if not auth.isAuthenticated
          token = store.get 'token'
          refreshToken = store.get 'refreshToken'
          if token
            if not jwtHelper.isTokenExpired token
              auth.authenticate store.get 'profile', token
            else
              if refreshToken
                return auth
                          .refreshIdToken refreshToken
                          .then (idToken) ->
                            store.set 'token', idToken
                            auth.authenticate store.get 'profile', idToken
              else
                $state.go 'login'
