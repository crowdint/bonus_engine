bonusApp.directive('affix', ->
  restrict: 'A'
  link: (scope, element, attrs)  ->
    $(element).affix({offset: {top: element.context.dataset.offsetTop}})
)