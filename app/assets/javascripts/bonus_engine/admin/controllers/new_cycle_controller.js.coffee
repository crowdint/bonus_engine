bonusAdminApp.controller 'adminNewCyclesCtrl', ($scope, $location, Cycle, User) ->
  $scope.partialUrl = "bonus_engine/admin/templates/cycles/new.html";
  $scope.btnLabel = 'Return to list of cycles'
  $scope.btnUrl = '/admin/bonus/cycles'
  $scope.cycleForm = new Cycle
  $scope.users = User.query()

  $scope.submitNewCycle = ->
    $scope.cycleForm.$save (cycle)->
      $location.path('/admin/bonus')
    , (error) ->
      $scope.erroOnCreate = true
