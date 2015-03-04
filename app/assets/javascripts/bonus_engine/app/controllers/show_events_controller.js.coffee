bonusApp.controller 'showEventsCtrl', ['$scope', '$routeParams', '$location', 'Event', 'User', 'Point', '$filter', '$modal', '$timeout', ($scope, $routeParams, $location, Event, User, Point, $filter, $modal, $timeout) ->
  $scope.cycleId = $routeParams.cycle_id
  $scope.eventId = $routeParams.event_id
  $scope.editingPoint = false;
  $scope.popoverMessage = 'There was an error assigning points'

  $scope.event = Event.get {cycle_id: $scope.cycleId, id: $scope.eventId}
  $scope.points = []

  User.get({cycle_id: $scope.cycleId, id: 'me'}, (user) ->
    $scope.currentUser = user

    User.query({cycle_id: $scope.cycleId}, (users) ->
      $scope.users = users

      angular.forEach($scope.users, (user) ->
        Point.query({cycle_id: $scope.cycleId, event_id: $scope.eventId, receiver_id: user.id, giver_id: $scope.currentUser.id }, (points) ->
          point = points[0]

          if point == undefined
            point = new Point({receiver_id: user.id})
            point.quantity = 0

          point.lastValidQty = point.quantity
          point.receiver = user
          $scope.calculateRemainingPoints()
          $scope.points.push point
        )
      )
    )
  )


  $scope.setMessage = (point) ->
    $scope.editingPoint = true

    modalInstance = $modal.open
      templateUrl: 'bonus_engine/app/templates/events/modal_message.html'
      controller: 'modalMessageCtrl'
      size: null
      backdrop: !$scope.event.active
      keyboard: !$scope.event.active
      resolve:
        pointToEdit: ->
          point
        eventActive: ->
          $scope.event.active

    modalInstance.result.then (message) ->
      if $scope.event.active
        point.message = message
        $scope.updatePoints(point)
      $scope.editingPoint = false

  $scope.pointChange = (point) ->
    $scope.calculateRemainingPoints()
    unless $scope.editingPoint
      if $scope.pointIsValid(point)
        $scope.setMessage point
      else
        $scope.invalidAssignment(point)

  $scope.pointIsValid = (point) ->
    $scope.remainingPoints >= 0 and point.quantity > 0 and
    point.quantity < $scope.remainingPoints and
    point.quantity < $scope.event.maximum_points and
    point.quantity > $scope.event.minimum_points

  $scope.invalidAssignment = (point) ->
    point.oldQuantity = point.quantity
    point.quantity = point.lastValidQty
    $scope.calculateRemainingPoints()
    $scope.triggerPopover(point)

  $scope.triggerPopover = (point) ->
    $scope.setPopoverMessage(point)
    point.invalidQty = true
    $timeout(->
      point.invalidQty = false
    , 500)

  $scope.setPopoverMessage = (point) ->
    if point.oldQuantity > $scope.event.maximum_points or point.oldQuantity < $scope.event.minimum_points
      $scope.popoverMessage = "You can assign between #{$scope.event.minimum_points} and #{$scope.event.maximum_points} points."
    else if point.oldQuantity > $scope.remainingPoints
      $scope.popoverMessage = "You only have #{$scope.remainingPoints} points available."


  $scope.calculateRemainingPoints =  ->
    $scope.remainingPoints = $scope.event.budget
    angular.forEach $scope.points, (point) ->
      point.quantity = 0 if point.quantity == undefined
      $scope.remainingPoints = $scope.remainingPoints - point.quantity

  $scope.updatePoints = (point) ->
    point.lastValidQty = point.quantity
    $scope.calculateRemainingPoints()
    if point.id
      point.$update({cycle_id: $scope.cycleId, event_id: $scope.eventId}, $scope.setUser)
    else
      point.$save({cycle_id: $scope.cycleId, event_id: $scope.eventId}, $scope.setUser)

  $scope.setUser = (point) ->
    point.receiver = $filter('filter')($scope.users, {id: point.receiver_id})[0];
]