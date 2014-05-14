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
        res <- PlanService.new(ideaId: idea.$name, goalId: goalId, num: 0).then
        planId = res.context.addedKey.split("/")[*-1]
        $location.url "/plans/#planId"
      else $location.url "/ideas/#{idea.$name}"

controllers.controller \IdeasNew do
  ($scope, $location, IdeaService)->
    $scope.save = ->
      <- IdeaService.new(content: $scope.ideaContent, type: \text).then
      $location.url(\/ideas)

controllers.controller \IdeasEdit do
  ($scope, $routeParams, $location, IdeaService)->
    $scope.id = $routeParams.id
    $scope.idea = IdeaService.find($scope.id)
    $scope.save = ->
      $scope.idea.$key(\content).$set($scope.idea.content)
      $location.url(\/ideas)




controllers.controller \GoalsIndex do
  ($scope, GoalService)->
    $scope.goals = GoalService.all!

controllers.controller \GoalsNew do
  ($scope, $location, GoalService, $routeParams)->
    $scope.save = ->
      toplevel = $routeParams.toplevel == \true

      GoalService.new do
        name:     $scope.goalName
        desc:     $scope.goalDesc
        toplevel: toplevel

      $location.url(\/)

controllers.controller \GoalsCreate do
  ($scope, $location, $routeParams, GoalService)->
    res <- GoalService.new($routeParams).then
    goalId = res.context.addedKey.split("/")[*-1]
    $location.url("/goals/#goalId")

controllers.controller \GoalsEdit do
  ($scope, $routeParams, GoalService, PlanService, $location)->
    $scope.id = id = $routeParams.id
    $scope.goal = goal = GoalService.find(id)
    $scope.plans = PlanService.where(goalId: id)
    $scope.save = ->
      goal.$key(\name).$set($scope.goal.name)
      goal.$key(\desc).$set($scope.goal.content)
      $location.url(\/toplevel) if goal.toplevel == \true
      $location.url("/plans/#{goal.planId}") if goal.planId




controllers.controller \PlansEdit do
  ($scope, $routeParams, PlanService, GoalService, $location)->
    $scope.id = id = $routeParams.id
    $scope.plan = plan = PlanService.find(id)
    $scope.goals = GoalService.where(planId: id)
    $scope.create = ->
      res <- GoalService.new(planId: id, pos: plan.num + 1).then
      plan.num++ 
      goalId = res.context.addedKey.split("/")[*-1]
      console.log(goalId)
      $location.url("/goals/#goalId")
      console.log(goalId)
