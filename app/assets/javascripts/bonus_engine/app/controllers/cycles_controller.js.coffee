bonusApp.controller 'cyclesCtrl', ['$scope', '$location', 'Cycle', ($scope, $location, Cycle) ->
  $scope.cycles = Cycle.query();
]