bonusAdminApp.controller 'adminEditCyclesCtrl', ($scope, $location, $routeParams, Cycle, User) ->
  $scope.partialUrl = "bonus_engine/admin/templates/cycles/edit.html";
  $scope.cycleForm = Cycle.get(id: $routeParams.id)
  $scope.btnLabel = 'Return to list of cycles'
  $scope.btnUrl = '/admin/bonus/cycles'
  $scope.users = User.query()

  $scope.submitEditCycle = ->
    $scope.cycleForm.$update (cycle)->
      $location.path('/admin/bonus')
    , (error) ->
      $scope.erroOnCreate = true
