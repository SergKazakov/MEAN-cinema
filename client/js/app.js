(function() {
  return angular.module('cinema', ['ngResource', 'ngMessages', 'ui.router', 'mgcrea.ngStrap', 'ngAnimate', 'satellizer']).config(function($urlRouterProvider, $locationProvider, $authProvider) {
    $urlRouterProvider.otherwise('/');
    $locationProvider.html5Mode(true);
    $authProvider.facebook({
      clientId: '1653435961554069'
    });
    $authProvider.google({
      clientId: '476828247245-ve3nh4f0fbcg0elggblkvctse9a26821.apps.googleusercontent.com'
    });
    $authProvider.github({
      clientId: '0ba2600b1dbdb756688b'
    });
    $authProvider.linkedin({
      clientId: '77cw786yignpzj'
    });
    $authProvider.yahoo({
      clientId: 'dj0yJmk9SDVkM2RhNWJSc2ZBJmQ9WVdrOWIzVlFRMWxzTXpZbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD0yYw--'
    });
    $authProvider.twitter({
      url: '/auth/twitter'
    });
    $authProvider.live({
      clientId: '0000000048152D9F'
    });
    return $authProvider.oauth2({
      name: 'foursquare',
      url: '/auth/foursquare',
      clientId: 'MTCEJ3NGW2PNNB31WOSBFDSAD4MTHYVAZ1UKIULXZ2CVFC2K',
      redirectUri: window.location.origin || window.location.protocol + '//' + window.location.host,
      authorizationEndpoint: 'https://foursquare.com/oauth2/authenticate'
    });
  });
})();

(function() {
  var passwordMatch;
  passwordMatch = function() {
    return {
      require: 'ngModel',
      scope: {
        otherModelValue: '=passwordMatch'
      },
      link: function(scope, element, attributes, ngModel) {
        ngModel.$validators.compareTo = function(modelValue) {
          return modelValue === scope.otherModelValue;
        };
        return scope.$watch('otherModelValue', function() {
          return ngModel.$validate();
        });
      }
    };
  };
  return angular.module('cinema').directive('passwordMatch', passwordMatch);
})();

(function() {
  var Account;
  Account = function($http) {
    return {
      getProfile: function() {
        return $http.get('/api/v1/me');
      },
      updateProfile: function(profileData) {
        return $http.put('/api/v1/me', profileData);
      }
    };
  };
  return angular.module('cinema').factory('Account', Account);
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
  HomeCtrl = function($state) {};
  return angular.module('cinema').controller('HomeCtrl', HomeCtrl);
})();

(function() {
  return angular.module('cinema').config(function($stateProvider) {
    return $stateProvider.state('login', {
      url: '/login',
      templateUrl: 'partials/login',
      controller: 'LoginCtrl'
    });
  });
})();

(function() {
  var LoginCtrl;
  LoginCtrl = function($scope, $alert, $auth) {
    $scope.login = function() {
      return $auth.login({
        email: $scope.email,
        password: $scope.password
      }).then(function() {
        return $alert({
          content: 'You have successfully logged in',
          animation: 'fadeZoomFadeDown',
          type: 'material',
          duration: 3
        });
      })["catch"](function(response) {
        return $alert({
          content: response.data.message,
          animation: 'fadeZoomFadeDown',
          type: 'material',
          duration: 3
        });
      });
    };
    $scope.authenticate = function(provider) {
      return $auth.authenticate(provider).then(function() {
        return $alert({
          content: 'You have successfully logged in',
          animation: 'fadeZoomFadeDown',
          type: 'material',
          duration: 3
        });
      })["catch"](function(response) {
        return $alert({
          content: response.data ? response.data.message : response,
          animation: 'fadeZoomFadeDown',
          type: 'material',
          duration: 3
        });
      });
    };
  };
  return angular.module('cinema').controller('LoginCtrl', LoginCtrl);
})();

(function() {
  var NavbarCtrl;
  NavbarCtrl = function($auth, $alert) {
    this.isAuthenticated = function() {
      return $auth.isAuthenticated();
    };
    this.logout = function(e) {
      e.preventDefault();
      return $auth.logout().then(function() {
        return $alert({
          content: 'You have been logged out',
          animation: 'fadeZoomFadeDown',
          type: 'material',
          duration: 3
        });
      });
    };
  };
  return angular.module('cinema').controller('NavbarCtrl', NavbarCtrl);
})();

(function() {
  return angular.module('cinema').config(function($stateProvider) {
    return $stateProvider.state('profile', {
      url: '/profile',
      templateUrl: 'partials/profile',
      controller: 'ProfileCtrl',
      resolve: {
        authenticated: function($q, $state, $auth) {
          var deferred;
          deferred = $q.defer();
          if (!$auth.isAuthenticated()) {
            $state.go('login');
          } else {
            deferred.resolve();
          }
          return deferred.promise;
        }
      }
    });
  });
})();

(function() {
  var ProfileCtrl;
  ProfileCtrl = function($scope, $auth, $alert, Account) {
    $scope.getProfile = function() {
      return Account.getProfile().success(function(data) {
        return $scope.user = data;
      }).error(function(error) {
        return $alert({
          content: error.message,
          animation: 'fadeZoomFadeDown',
          type: 'material',
          duration: 3
        });
      });
    };
    $scope.getProfile();
    $scope.updateProfile = function() {
      Account.updateProfile({
        displayName: $scope.user.displayName,
        email: $scope.user.email
      }).then(function() {});
      return $alert({
        content: 'Profile has been updated',
        animation: 'fadeZoomFadeDown',
        type: 'material',
        duration: 3
      });
    };
    $scope.link = function(provider) {
      return $auth.link(provider).then(function() {
        return $alert({
          content: 'You have successfully linked ' + provider + ' account',
          animation: 'fadeZoomFadeDown',
          type: 'material',
          duration: 3
        });
      }).then(function() {
        return $scope.getProfile();
      })["catch"](function(response) {
        return $alert({
          content: response.data.message,
          animation: 'fadeZoomFadeDown',
          type: 'material',
          duration: 3
        });
      });
    };
    $scope.unlink = function(provider) {
      return $auth.unlink(provider).then(function() {
        return $alert({
          content: 'You have successfully unlinked ' + provider + ' account',
          animation: 'fadeZoomFadeDown',
          type: 'material',
          duration: 3
        });
      }).then(function() {
        return $scope.getProfile();
      })["catch"](function(response) {
        return $alert({
          content: response.data ? response.data.message : 'Could not unlink ' + provider + ' account',
          animation: 'fadeZoomFadeDown',
          type: 'material',
          duration: 3
        });
      });
    };
  };
  return angular.module('cinema').controller('ProfileCtrl', ProfileCtrl);
})();

(function() {
  return angular.module('cinema').config(function($stateProvider) {
    return $stateProvider.state('signup', {
      url: '/signup',
      templateUrl: 'partials/signup',
      controller: 'SignupCtrl'
    });
  });
})();

(function() {
  var SignupCtrl;
  SignupCtrl = function($scope, $alert, $auth) {
    $scope.signup = function() {
      return $auth.signup({
        displayName: $scope.displayName,
        email: $scope.email,
        password: $scope.password
      })["catch"](function(response) {
        if (typeof response.data.message === 'object') {
          return angular.forEach(response.data.message, function(message) {
            return $alert({
              content: message[0],
              animation: 'fadeZoomFadeDown',
              type: 'material',
              duration: 3
            });
          });
        } else {
          return $alert({
            content: response.data.message,
            animation: 'fadeZoomFadeDown',
            type: 'material',
            duration: 3
          });
        }
      });
    };
  };
  return angular.module('cinema').controller('SignupCtrl', SignupCtrl);
})();
