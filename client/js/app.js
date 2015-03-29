(function() {
  return angular.module('cinema', ['ui.router', 'auth0', 'angular-storage', 'angular-jwt', 'mgcrea.ngStrap', 'ngAnimate']).config(function($urlRouterProvider, $locationProvider, authProvider, $httpProvider, jwtInterceptorProvider) {
    $urlRouterProvider.otherwise('/');
    authProvider.init({
      domain: 'sergeykazakoff-test.auth0.com',
      clientID: 'XPQYEuy68HSlowXjeRJuA4xK9V8HaZdX',
      loginState: 'login'
    });
    authProvider.on('loginSuccess', function($state, profilePromise, idToken, refreshToken, store) {
      $state.go('profile');
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
  var authFactory;
  authFactory = function($state, auth, store, $alert) {
    return {
      login: function() {
        return auth.signin({
          socialBigButtons: true,
          authParams: {
            scope: 'openid offline_access'
          }
        }, function() {
          return $alert({
            content: 'Вы успешно вошли в свою учетную запись',
            type: 'success',
            duration: 2
          });
        });
      },
      logout: function() {
        auth.signout();
        store.remove('profile');
        store.remove('token');
        $state.go('home');
        return $alert({
          content: 'Вы вышли из учетной записи',
          type: 'success',
          duration: 2
        });
      }
    };
  };
  return angular.module('cinema').factory('authFactory', authFactory);
})();

(function() {
  return angular.module('cinema').config(function($stateProvider) {
    return $stateProvider.state('home', {
      url: '/',
      templateUrl: 'partials/home',
      controller: 'HomeCtrl as home'
    });
  });
})();

(function() {
  var HomeCtrl;
  HomeCtrl = function($state, auth, store) {};
  return angular.module('cinema').controller('HomeCtrl', HomeCtrl);
})();

(function() {
  return angular.module('cinema').config(function($stateProvider) {
    return $stateProvider.state('login', {
      url: '/login',
      controller: 'LoginCtrl as login'
    });
  });
})();

(function() {
  var LoginCtrl;
  LoginCtrl = function(auth, authFactory) {
    authFactory.login();
  };
  return angular.module('cinema').controller('LoginCtrl', LoginCtrl);
})();

(function() {
  var NavbarCtrl;
  NavbarCtrl = function($state, auth, authFactory) {
    this.auth = auth;
    this.logout = function(e) {
      e.preventDefault();
      return authFactory.logout();
    };
  };
  return angular.module('cinema').controller('NavbarCtrl', NavbarCtrl);
})();

(function() {
  return angular.module('cinema').config(function($stateProvider) {
    return $stateProvider.state('profile', {
      url: '/profile',
      templateUrl: 'partials/profile',
      controller: 'ProfileCtrl as profile',
      data: {
        requiresLogin: true
      }
    });
  });
})();

(function() {
  var ProfileCtrl;
  ProfileCtrl = function(auth) {
    this.auth = auth;
  };
  return angular.module('cinema').controller('ProfileCtrl', ProfileCtrl);
})();
