bonusApp.directive('popoverEvent',['$timeout', ($timeout) ->
  restrict: 'A'
  link: (scope, element, attrs)  ->
    scope.$watch("point.invalidQty", (newValue, oldValue) ->
      if newValue == true
        angular.element(element).trigger('openTrigger')
      else
        $timeout( ->
          angular.element(element).trigger('closeTrigger')
        , 500)
    )
])