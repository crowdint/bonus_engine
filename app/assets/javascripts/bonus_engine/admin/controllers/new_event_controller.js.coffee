bonusAdminApp.controller 'adminNewEventCtrl', ['$scope', '$location', 'Event', '$routeParams', ($scope, $location, Event, $routeParams) ->
  $scope.partialUrl = "bonus_engine/admin/templates/events/new.html";
  $scope.btnLabel = 'Return to list of events'
  $scope.cycle_id = $routeParams.cycle_id
  $scope.btnUrl = '/admin/bonus/cycles/' + $scope.cycle_id + '/events'
  $scope.eventForm = new Event()

  $scope.submitNewEvent = ->
    $scope.eventForm.$save {cycle_id: $scope.cycle_id }, (cycle)->
      $location.path('/admin/bonus/cycles/' + $scope.cycle_id + '/events')
    , (error) ->
      $scope.erroOnCreate = true

]