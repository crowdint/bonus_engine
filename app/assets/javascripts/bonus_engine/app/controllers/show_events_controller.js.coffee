bonusApp.controller 'showEventsCtrl', ['$scope', '$routeParams', '$location', 'Event', 'User', 'Point', '$filter', '$modal', '$timeout', 'Cycle', ($scope, $routeParams, $location, Event, User, Point, $filter, $modal, $timeout, Cycle) ->
  $scope.cycleId = $routeParams.cycle_id
  $scope.eventId = $routeParams.event_id
  $scope.editingPoint = false;
  $scope.popoverMessage = 'There was an error assigning points'

  $scope.event = Event.get {cycle_id: $scope.cycleId, id: $scope.eventId}
  $scope.cycle = Cycle.get {id: $scope.cycleId}
  $scope.points = []

  User.get({cycle_id: $scope.cycleId, id: 'me'}, (user) ->
    $scope.currentUser = user

    User.query({cycle_id: $scope.cycleId}, (users) ->
      $scope.users = users

      angular.forEach($scope.users, (user) ->
        Point.query({cycle_id: $scope.cycleId, event_id: $scope.eventId, receiver_id: user.id, giver_id: $scope.currentUser.id }, (points) ->
          point = points[0]

          if point == undefined
            point = new Point({receiver_id: user.id, quantity: 0, message: ''})

          point.lastValidQty = point.quantity || 0
          point.lastValidMsg = point.message
          point.receiver = user
          $scope.points.push point
          $scope.remainingPoints = $scope.calculateRemainingPoints()
        )
      )
    )
  )

  $scope.pointChange = (point) ->
    point.editingMessage = false
    if $scope.pointIsChanged(point)
      if $scope.pointIsValid(point) && $scope.messageIsValid(point)
        $scope.updatePoints point
      else
        $scope.invalidAssignment(point)

  $scope.pointIsValid = (point) ->
    (($scope.remainingPoints >= 0 and point.quantity > 0 and
    point.quantity <= $scope.remainingPoints) or
    ($scope.remainingPoints == 0 and point.quantity < point.lastValidQty)) and
    point.quantity <= $scope.event.maximum_points and
    point.quantity >= $scope.event.minimum_points

  $scope.messageIsValid = (point) ->
    point.message != undefined and point.message.length >= 20

  $scope.invalidAssignment = (point) ->
    $scope.triggerPopover(point)
    point.quantity = point.lastValidQty unless $scope.pointIsValid(point)

  $scope.errorOnMessage = (point) ->
    !$scope.messageIsValid(point) and $scope.pointIsValid(point)

  $scope.triggerPopover = (point) ->
    $scope.setPopoverMessage(point)
    point.invalidQty = true
    $timeout(->
      point.invalidQty = false
    , 500)

  $scope.setPopoverMessage = (point) ->
    if !$scope.messageIsValid(point) and $scope.pointIsValid(point)
      $scope.popoverMessage = "Please, share with your coworker why he/she earn your points."
    else if point.quantity > $scope.remainingPoints
      $scope.popoverMessage = "You only have #{$scope.remainingPoints} points available."
    else if point.quantity > $scope.event.maximum_points or point.quantity < $scope.event.minimum_points or point.quantity == undefined
      $scope.popoverMessage = "You can assign between #{$scope.event.minimum_points} and #{$scope.event.maximum_points} points."

  $scope.calculateRemainingPoints =  ->
    remainingPoints = $scope.event.budget
    angular.forEach $scope.points, (point) ->
      point.quantity = 0 if point.quantity == undefined
      remainingPoints = remainingPoints - point.quantity
    remainingPoints

  $scope.updatePoints = (point) ->
    $scope.remainingPoints = $scope.calculateRemainingPoints()
    point.lastValidQty = point.quantity
    point.lastValidMsg = point.message
    if point.id
      point.$update({cycle_id: $scope.cycleId, event_id: $scope.eventId}, $scope.afterSave)
    else
      point.$save({cycle_id: $scope.cycleId, event_id: $scope.eventId}, $scope.afterSave)

  $scope.afterSave = (point) ->
    point.lastValidQty = point.quantity
    point.lastValidMsg = point.message
    point.receiver = $filter('filter')($scope.users, {id: point.receiver_id})[0];
    $scope.pointSuccessfullySaved(point)

  $scope.editingMessage = (point) ->
    point.message = '' if point.message == undefined
    point.editingMessage = true

  $scope.pointIsChanged = (point) ->
    point.lastValidQty != point.quantity or
    point.lastValidMsg != point.message

  $scope.pointSuccessfullySaved = (point) ->
    point.saving = true
    $timeout( ->
      point.saving = false
    , 1000)

]