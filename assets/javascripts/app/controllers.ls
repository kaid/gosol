controllers = angular.module \gosol.controllers <[gosol.providers]>

controllers.controller \ToplevelIndex do
  ($scope, GoalService)->
    $scope.toplevel = true
    $scope.goals = GoalService.where(toplevel: true)




controllers.controller \IdeasIndex do
  ($scope, $routeParams, IdeaService, PlanService, $location)->
    $scope.goalId = goalId = $routeParams.goalId
    $scope.ideas = IdeaService.all!
    $scope.link = (idea)->
      if goalId
        res <- PlanService.new(ideaId: idea.$name, goalId: goalId).then
        planId = res.context.addedKey.split("/")[*-1]
        $location.path "/plans/#planId"
      else $location.path "/ideas/#{idea.$name}"

controllers.controller \IdeasNew do
  ($scope, $location, IdeaService)->
    $scope.save = ->
      <- IdeaService.new(content: $scope.ideaContent, type: \text).then
      $location.path(\/ideas)

controllers.controller \IdeasEdit do
  ($scope, $routeParams, $location, IdeaService)->
    $scope.id = $routeParams.id
    $scope.idea = IdeaService.find($scope.id)
    $scope.save = ->
      $scope.idea.$key(\content).$set($scope.idea.content)
      $location.path(\/ideas)




controllers.controller \GoalsIndex do
  ($scope, GoalService)->
    $scope.goals = GoalService.all!

controllers.controller \GoalsNew do
  ($scope, $location, GoalService, $routeParams)->
    $scope.save = ->
      toplevel = $routeParams.toplevel == \true

      params = do
        name:     $scope.goalName
        desc:     $scope.goalDesc
        toplevel: toplevel

      GoalService.new(params)
      $location.path(\/)

controllers.controller \GoalsEdit do
  ($scope, $routeParams, GoalService, PlanService, $location)->
    $scope.id = id = $routeParams.id
    $scope.goal = goal = GoalService.find(id)
    $scope.plans = PlanService.where(goalId: id)
    $scope.save = ->
      goal.$key(\name).$set($scope.goal.name)
      goal.$key(\desc).$set($scope.goal.content)
      $location.path(\/toplevel) if goal.toplevel == \true
      $location.path("/plans/#{goal.planId}") if goal.planId




controllers.controller \PlansIndex do
  ($scope, $routeParams)->
    console.log $routeParams

controllers.controller \PlansEdit do
  ($scope, $routeParams, PlanService, $location, GoalService)->
    $scope.id = id = $routeParams.id
    $scope.plan = PlanService.find(id)
    $scope.link = (plan)->
      res <- GoalService.new(planId: id).then
      goalId = res.context.addedKey.split("/")[*-1]
      console.error "goalId!!!!: #goalId"
      $location.path "/goals/#goalId"
      
    $scope.goals = GoalService.where(planId: id)
