bonusAdminApp.controller 'adminEventsCtrl', ['$scope', '$location', '$routeParams', 'Event', ($scope, $location, $routeParams, Event) ->
  $scope.partialUrl = "bonus_engine/admin/templates/events/index.html";
  $scope.cycle_id = $routeParams.cycle_id
  $scope.btnLabel = 'Create new event'
  $scope.btnUrl = '/admin/bonus/cycles/' + $scope.cycle_id + '/events/new'



  $scope.events = Event.query({cycle_id: $scope.cycle_id});
]