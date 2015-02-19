bonusAdminApp.controller 'adminCyclesCtrl', ($scope, $location, Cycle) ->
  $scope.partialUrl = "bonus_engine/admin/templates/cycles/index.html";
  $scope.btnLabel = 'Create new cycle'
  $scope.btnUrl = '/admin/bonus/cycles/new'

  $scope.cycles = Cycle.query();