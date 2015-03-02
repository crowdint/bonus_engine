bonusApp.controller 'modalMessageCtrl', ['$scope', '$modalInstance', 'pointToEdit', 'eventActive', ($scope, $modalInstance, pointToEdit, eventActive) ->
  $scope.message = pointToEdit.message
  $scope.pointToEdit = pointToEdit
  $scope.buttonDisabled = if $scope.message.length >= 20 then false else true
  $scope.eventActive = eventActive

  console.log($scope.eventActive)

  $scope.validateMinLength = ->
    if $scope.message.length >= 20
      $scope.buttonDisabled = false
    else
      $scope.buttonDisabled = true

  $scope.ok = ->
    $modalInstance.close($scope.message);

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');

  $scope.open = ($event) ->
    $event.preventDefault();
    $event.stopPropagation();

    $scope.opened = true;
]