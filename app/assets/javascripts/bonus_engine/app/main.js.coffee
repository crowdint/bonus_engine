window.bonusApp ||= angular.module('BonusApp', [
  'ngResource',
  'ngAnimate',
  'ngRoute',
  'templates',
  'ng-rails-csrf',
  'ui.bootstrap'
  ]).config(($routeProvider, $locationProvider, $httpProvider) ->

    $routeProvider
      .when '/bonus', {
        templateUrl: 'bonus_engine/app/templates/cycles/index.html',
        controller: 'cyclesCtrl'
      }
      .when '/cycles/:cycle_id/events', {
        templateUrl: 'bonus_engine/app/templates/events/index.html',
        controller: 'eventsCtrl'
      }
      .when '/cycles/:cycle_id/events/:event_id', {
        templateUrl: 'bonus_engine/app/templates/events/show.html',
        controller: 'showEventsCtrl'
      }
      .when '/cycles/:cycle_id/events/:event_id/me', {
        templateUrl: 'bonus_engine/app/templates/events/me.html',
        controller: 'meEventsCtrl'
      }
      .otherwise {redirectTo: '/bonus'}

    $locationProvider.html5Mode(true)

    $httpProvider.defaults.useXDomain = true;
    delete $httpProvider.defaults.headers.common["X-Requested-With"];

)
