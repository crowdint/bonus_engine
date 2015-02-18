bonusApp.controller 'showEventsCtrl', ($scope, $routeParams, $location, Event, User, Point, $filter, $modal) ->
  $scope.cycleId = $routeParams.cycle_id
  $scope.eventId = $routeParams.event_id

  $scope.event = Event.get {cycle_id: $scope.cycleId, id: $scope.eventId}
  $scope.points = []

  User.query({cycle_id: $scope.cycleId}, (users) ->
    $scope.users = users

    angular.forEach($scope.users, (user) ->
      Point.query({cycle_id: $scope.cycleId, event_id: $scope.eventId, receiver_id: user.id }, (points) ->
        point = points[0]

        if point == undefined
          point = new Point({receiver_id: user.id})
          point.quantity = 0

        point.receiver = user

        $scope.calculateRemainingPoints()

        $scope.points.push point
      )
    )
  )

  $scope.pointChange = (point) ->
    if $scope.remainingPoints > 0
      $scope.calculateRemainingPoints()
      point.message = 'prueba'
      $scope.updatePoints point
    else
      point.quantity = 0
      $scope.calculateRemainingPoints()

  $scope.calculateRemainingPoints =  ->
    $scope.remainingPoints = $scope.event.budget
    angular.forEach $scope.points, (point) ->
      $scope.remainingPoints = $scope.remainingPoints - point.quantity

  $scope.updatePoints = (point) ->
    if point.id
      point.$update({cycle_id: $scope.cycleId, event_id: $scope.eventId}, $scope.setUser)
    else
      point.$save({cycle_id: $scope.cycleId, event_id: $scope.eventId}, $scope.setUser)

  $scope.setUser = (point) ->
    point.receiver = $filter('filter')($scope.users, {id: point.receiver_id})[0];