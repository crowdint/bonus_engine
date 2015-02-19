bonusAdminApp.controller 'adminNewCyclesCtrl', ($scope, $location, Cycle) ->
  $scope.partialUrl = "bonus_engine/admin/templates/cycles/new.html";
  $scope.btnLabel = 'Return to list of cycles'
  $scope.btnUrl = '/admin/bonus/cycles'
  $scope.cycleForm = new Cycle

  $scope.submitNewCycle = ->
    $scope.cycleForm.$save (cycle)->
      $location.path('/admin/bonus')
    , (error) ->
      $scope.erroOnCreate = true
