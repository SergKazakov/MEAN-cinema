(function() {
  return angular.module('cinema', ['ui.router', 'auth0', 'angular-storage', 'angular-jwt']).config(function($urlRouterProvider, $locationProvider, authProvider, $httpProvider, jwtInterceptorProvider) {
    $urlRouterProvider.otherwise('/');
    $locationProvider.html5Mode(true);
    authProvider.init({
      domain: 'sergeykazakoff-test.auth0.com',
      clientID: 'XPQYEuy68HSlowXjeRJuA4xK9V8HaZdX',
      callbackURL: location.href,
      loginState: 'login'
    });
    jwtInterceptorProvider.tokenGetter = function(aiStorage) {
      return aiStorage.get('token');
    };
    return $httpProvider.interceptors.push('jwtInterceptor');
  }).run(function($rootScope, auth, aiStorage, jwtHelper, $state) {
    return $rootScope.$on('$locationChangeStart', function() {
      var token;
      if (!auth.isAuthenticated) {
        token = aiStorage.get('token');
        if (token) {
          if (!jwtHelper.isTokenExpired(token)) {
            return auth.authenticate(aiStorage.get('profile'), token);
          } else {
            return $state.go('login');
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
  HomeCtrl = function($state, auth, aiStorage) {
    this.logout = function() {
      auth.signout();
      aiStorage.remove('profile');
      aiStorage.remove('token');
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
  LoginCtrl = function($state, auth, aiStorage) {
    this.login = function() {
      return auth.signin({}, function(profile, token) {
        aiStorage.set('profile', profile);
        aiStorage.set('token', token);
        return $state.go('home');
      }, function(error) {
        return console.log('There was an error logging in', error);
      });
    };
  };
  return angular.module('cinema').controller('LoginCtrl', LoginCtrl);
})();
