bonusAdminApp.controller 'adminResultsEventCtrl', ['$scope', '$location', 'Event', '$routeParams', 'User', 'Point', '$filter', ($scope, $location, Event, $routeParams, User, Point, $filter) ->
  $scope.partialUrl = "bonus_engine/admin/templates/events/results.html";
  $scope.btnLabel = 'Return to list of events'
  $scope.cycleId = $routeParams.cycle_id
  $scope.eventId = $routeParams.id
  $scope.btnUrl = '/admin/bonus/cycles/' + $scope.cycle_id + '/events'
  $scope.points = []
  $scope.users = []
  $scope.labels = []
  $scope.data = [[], []]
  $scope.series = ['Received point', 'Peers shared']


  Point.query({event_id: $scope.eventId}, (points) ->
    $scope.points = points
    User.query({cycle_id: $scope.cycleId}, (users) ->
      $scope.users = users

      angular.forEach($scope.users, (user) ->

        user.received_points = 0
        user.given_peers = 0
        $scope.labels.push(user.name)

        angular.forEach($scope.points, (point) ->
          if point.receiver_id == user.id
            user.received_points = user.received_points + point.quantity
          if point.giver_id == user.id
            user.given_peers = user.given_peers + 1
        )
        $scope.data[0].push(user.received_points)
        $scope.data[1].push(user.given_peers)
      )
    )
  )
]