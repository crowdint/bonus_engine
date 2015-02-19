bonusApp.controller 'eventsCtrl', ($scope, $routeParams, $location, Event, User, Point, $filter) ->
  $scope.cycleId = $routeParams.cycle_id
  $scope.events = Event.query({cycle_id: $scope.cycleId})
