bonusAdminApp.controller 'adminCyclesCtrl', ($scope, $location, Cycle) ->
  $scope.partialUrl = "bonus_engine/app/templates/cycles/index.html";
  $scope.resource = 'cycles'

  $scope.cycles = Cycle.query();