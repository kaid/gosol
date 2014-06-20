directives = angular.module \gosol.directives <[gosol.lib]>

directives.directive \gosolTree do
  (GosolCanvas)->
    link = (scope, element, attrs)->
      new GosolCanvas(scope, element)

    do
      restrict: \E

      scope:
        root: \=root

      link: link
