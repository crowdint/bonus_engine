bonusApp.controller 'showUsersCtrl', ($scope, $routeParams, $location, Event, User, Point, $filter) ->
  $scope.cycleId = $routeParams.cycle_id
  $scope.eventId = $routeParams.event_id
  $scope.userId = $routeParams.user_id
  $scope.event = Event.get {cycle_id: $scope.cycleId, id: $scope.eventId}

  $scope.points = []

  User.get({cycle_id: $scope.cycleId, id: $scope.userId}, (user) ->
    $scope.user = user

    Point.query({cycle_id: $scope.cycleId, event_id: $scope.eventId, receiver_id: $scope.user.id }, (points) ->
      $scope.points = points
      angular.forEach($scope.points, (point) ->
        user = User.get({cycle_id: $scope.cycleId, id: point.giver_id}, (user) ->
          point.giver = user
          console.log(point.giver)
        )
      )
    )
  )
