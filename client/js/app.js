(function() {
  return angular.module('cinema', ['ui.router', 'auth0', 'angular-storage', 'angular-jwt']).config(function($urlRouterProvider, $locationProvider, authProvider, $httpProvider, jwtInterceptorProvider) {
    $urlRouterProvider.otherwise('/');
    authProvider.init({
      domain: 'sergeykazakoff-test.auth0.com',
      clientID: 'XPQYEuy68HSlowXjeRJuA4xK9V8HaZdX',
      loginState: 'login'
    });
    authProvider.on('loginSuccess', function($state, profilePromise, idToken, refreshToken, store) {
      $state.go('home');
      store.set('token', idToken);
      store.set('refreshToken', refreshToken);
      return profilePromise.then(function(profile) {
        return store.set('profile', profile);
      });
    });
    authProvider.on('loginFailure', function($log, error) {
      return $log('Error logging in', error);
    });
    jwtInterceptorProvider.tokenGetter = function(store, jwtHelper, auth) {
      var idToken, refreshToken;
      idToken = store.get('token');
      refreshToken = store.get('refreshToken');
      if (!idToken || !refreshToken) {
        return null;
      }
      if (jwtHelper.isTokenExpired(idToken)) {
        return auth.refreshIdToken(refreshToken).then(function(idToken) {
          store.set('token', idToken);
          return idToken;
        });
      } else {
        return idToken;
      }
    };
    return $httpProvider.interceptors.push('jwtInterceptor');
  }).run(function($rootScope, auth, store, jwtHelper, $state) {
    return $rootScope.$on('$locationChangeStart', function() {
      var refreshToken, token;
      if (!auth.isAuthenticated) {
        token = store.get('token');
        refreshToken = store.get('refreshToken');
        if (token) {
          if (!jwtHelper.isTokenExpired(token)) {
            return auth.authenticate(store.get('profile', token));
          } else {
            if (refreshToken) {
              return auth.refreshIdToken(refreshToken).then(function(idToken) {
                store.set('token', idToken);
                return auth.authenticate(store.get('profile', idToken));
              });
            } else {
              return $state.go('login');
            }
          }
        }
      }
    });
  });
})();

(function() {
  return angular.module('cinema').config(function($stateProvider) {
    return $stateProvider.state('home', {
      url: '/',
      templateUrl: 'partials/home',
      controller: 'HomeCtrl as home',
      data: {
        requiresLogin: true
      }
    });
  });
})();

(function() {
  var HomeCtrl;
  HomeCtrl = function($state, auth, store) {
    this.auth = auth;
    this.logout = function() {
      auth.signout();
      store.remove('profile');
      store.remove('token');
      return $state.go('login');
    };
  };
  return angular.module('cinema').controller('HomeCtrl', HomeCtrl);
})();

(function() {
  return angular.module('cinema').config(function($stateProvider) {
    return $stateProvider.state('login', {
      url: '/login',
      templateUrl: 'partials/login',
      controller: 'LoginCtrl as login'
    });
  });
})();

(function() {
  var LoginCtrl;
  LoginCtrl = function(auth) {
    this.login = function() {
      return auth.signin({
        socialBigButtons: true,
        authParams: {
          scope: 'openid offline_access'
        }
      });
    };
  };
  return angular.module('cinema').controller('LoginCtrl', LoginCtrl);
})();
