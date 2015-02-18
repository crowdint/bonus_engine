window.bonusAdminApp ||= angular.module('BonusAdminApp', [
  'ngResource',
  'ngAnimate',
  'ngRoute',
  'templates'
  ]).config(($routeProvider, $locationProvider, $httpProvider) ->

    $routeProvider
      .when '/admin/bonus', {
        templateUrl: 'bonus_engine/app/templates/main.html',
        controller: 'cyclesCtrl'
      }
      .when '/admin/bonus/cycles/new', {
        templateUrl: 'bonus_engine/app/templates/main.html',
        controller: 'NewCyclesCtrl'
      }
      .otherwise {redirectTo: '/admin/bonus'}

    $locationProvider.html5Mode(true)

    $httpProvider.defaults.useXDomain = true;
    delete $httpProvider.defaults.headers.common["X-Requested-With"];

)
