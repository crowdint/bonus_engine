bonusApp.controller 'eventsCtrl', ['$scope', '$routeParams', '$location', 'Event', 'User', 'Point', '$filter', ($scope, $routeParams, $location, Event, User, Point, $filter) ->
  $scope.cycleId = $routeParams.cycle_id
  Event.query({cycle_id: $scope.cycleId}, (events) ->
    $scope.events = events
    angular.forEach($scope.events, (event) ->
      event.info.distributedPoints = event.budget - event.info.balance
    )
  )
]