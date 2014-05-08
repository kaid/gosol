angular <- define <[angular app/providers]>

controllers = angular.module \gosol.controllers <[gosol.providers]>

controllers.controller \IdeasController do
  [\$scope \ideasFactory ($scope, ideasFactory)->
    $scope.ideas = ideasFactory
  ]

controllers.controller \IdeaController do
  [\$scope \$routeParams \ideaFactory ($scope, $params, ideaFactory)->
    $scope.idea = ideaFactory($params.id)
  ]

controllers.controller \GoalsController do
  [\$scope ($scope)->
    $scope.goals = []
  ]

controllers.controller \GoalController do
  [\$scope \$routeParams ($scope, $params)->
    goals       = []
    $scope.goal = goals[$params.id - 1]
  ]
