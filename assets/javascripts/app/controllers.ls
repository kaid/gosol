angular <- define <[angular app/factories]>

controllers = angular.module \gosol.controllers []
injector    = angular.injector <[gosol.factories]>

controllers.controller \GoalListController do
  [\$scope ($scope)->
    $scope.goals = injector.get \goals
  ]

controllers.controller \GoalController do
  [\$scope \$routeParams ($scope, $params)->
    goals       = injector.get \goals
    $scope.goal = goals[$params.id - 1]
  ]
