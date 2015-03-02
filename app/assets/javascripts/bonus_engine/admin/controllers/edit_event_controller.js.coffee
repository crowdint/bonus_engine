bonusAdminApp.controller 'adminEditEventCtrl', ['$scope', '$location', '$routeParams', 'Event', ($scope, $location, $routeParams, Event) ->
  $scope.partialUrl = "bonus_engine/admin/templates/events/edit.html";
  $scope.cycle_id = $routeParams.cycle_id
  $scope.eventForm = Event.get({cycle_id: $scope.cycle_id, id: $routeParams.id})
  $scope.btnLabel = 'Return to list of events'
  $scope.btnUrl = '/admin/bonus/cycles/' + $scope.cycle_id + '/events'

  $scope.submitEditEvent = ->
    $scope.eventForm.$update {cycle_id: $scope.cycle_id}, (event)->
      $location.path($scope.btnUrl)
    , (error) ->
      $scope.erroOnCreate = true
]