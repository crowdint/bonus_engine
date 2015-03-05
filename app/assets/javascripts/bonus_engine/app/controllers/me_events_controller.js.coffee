bonusApp.controller 'meEventsCtrl', ['$scope', '$routeParams', '$location', 'Event', 'User', 'Point', '$filter', 'Cycle', ($scope, $routeParams, $location, Event, User, Point, $filter, Cycle) ->
  $scope.cycleId = $routeParams.cycle_id
  $scope.eventId = $routeParams.event_id
  $scope.event = Event.get {cycle_id: $scope.cycleId, id: $scope.eventId}
  $scope.cycle = Cycle.get {id: $scope.cycleId}

  $scope.points = []
  $scope.totalPoints = 0

  User.get({cycle_id: $scope.cycleId, id: 'me'}, (user) ->
    $scope.user = user

    Point.query({cycle_id: $scope.cycleId, event_id: $scope.eventId, receiver_id: user.id }, (points) ->
      $scope.points = points
      angular.forEach($scope.points, (point) ->
        user = User.get({cycle_id: $scope.cycleId, id: point.giver_id}, (user) ->
          point.giver = user
        )
        $scope.totalPoints = $scope.totalPoints + point.quantity
      )
    )
  )
]