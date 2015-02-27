window.bonusAdminApp ||= angular.module('BonusAdminApp', [
  'ngResource',
  'ngAnimate',
  'ngRoute',
  'ng-rails-csrf',
  'templates',
  'ui.bootstrap'
  ]).config(($routeProvider, $locationProvider, $httpProvider) ->

    $routeProvider
      .when '/admin/bonus', {
        templateUrl: 'bonus_engine/admin/templates/main.html',
        controller: 'adminCyclesCtrl'
      }
      .when '/admin/bonus/cycles/new', {
        templateUrl: 'bonus_engine/admin/templates/main.html',
        controller: 'adminNewCyclesCtrl'
      }
      .when '/admin/bonus/cycles/:id/edit', {
        templateUrl: 'bonus_engine/admin/templates/main.html',
        controller: 'adminEditCyclesCtrl'
      }
      .when '/admin/bonus/cycles/:cycle_id/events', {
        templateUrl: 'bonus_engine/admin/templates/main.html',
        controller: 'adminEventsCtrl'
      }
      .when '/admin/bonus/cycles/:cycle_id/events/new', {
        templateUrl: 'bonus_engine/admin/templates/main.html',
        controller: 'adminNewEventCtrl'
      }
      .when '/admin/bonus/cycles/:cycle_id/events/:id/edit', {
        templateUrl: 'bonus_engine/admin/templates/main.html',
        controller: 'adminEditEventCtrl'
      }
      .otherwise {redirectTo: '/admin/bonus'}

    $locationProvider.html5Mode(true)

    $httpProvider.defaults.useXDomain = true;
    delete $httpProvider.defaults.headers.common["X-Requested-With"];

)
