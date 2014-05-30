controllers = angular.module \gosol.controllers <[gosol.providers]>

controllers.controller \ToplevelIndex do
  ($scope, GoalService)->
    GoalService.where((doc)-> doc.toplevel).then (res)->
      $scope.goals = res.rows.map (item)-> item.key



controllers.controller \IdeasIndex do
  ($scope, $routeParams, IdeaService, PlanService, $location)->
    $scope.goalId = goalId = $routeParams.goalId

    IdeaService.where((doc)-> doc.goalId == goalId).then (res)->
      $scope.ideas = res.rows.map (item)-> item.key
      console.log $scope.ideas

    $scope.link = (idea)->
      res <- PlanService.create(ideaId: idea._id, goalId: goalId).then
      $location.url "/plans/#{res.id}"

controllers.controller \IdeasNew do
  ($scope, $location, IdeaService, $routeParams)->
    $scope.idea = type: \text, goalId: $routeParams.goalId

    console.log $scope.idea

    $scope.save = ->
      <- IdeaService.create($scope.idea).then
      $location.path(\/ideas)

controllers.controller \IdeasEdit do
  ($scope, $routeParams, $location, IdeaService)->
    $scope.id = $routeParams.id

    IdeaService.find($scope.id).then (idea)->
      $scope.idea = idea

    $scope.save = ->
      <- IdeaService.update($scope.idea).then
      $location.url("/ideas?goalId=#{$scope.idea.goalId}")




controllers.controller \GoalsNew do
  ($scope, $location, GoalService, $routeParams)->
    toplevel = $routeParams.toplevel == \true

    $scope.goal = {toplevel: toplevel}

    $scope.save = ->
      <-GoalService.create($scope.goal).then
      $location.url(\/)

controllers.controller \GoalsEdit do
  ($scope, $routeParams, GoalService, PlanService, IdeaService, $location)->
    $scope.id = id = $routeParams.id

    GoalService.find(id).then (goal)->
      $scope.goal = goal

    IdeaService.where((doc)-> doc.goalId == id).then (res)->
      $scope.ideas = res.rows.map (item)->
        idea = item.key

        PlanService.where((doc) -> doc.ideaId == idea._id).then (res)->
          idea.plans = res.rows.map (item)-> item.key

        idea

    $scope.save = ->
      goal <- GoalService.update($scope.goal).then
      $location.url(\/toplevel) if $scope.goal.toplevel
      $location.url("/plans/#{$scope.goal.planId}") if $scope.goal.planId




controllers.controller \PlansEdit do
  ($scope, $routeParams, PlanService, GoalService, $location)->
    $scope.id = id = $routeParams.id

    PlanService.find(id).then (plan)->
      $scope.plan = plan

    GoalService.where((doc) -> doc.planId == id).then (res)->
      $scope.goals = res.rows.map (item)-> item.key
      $scope.num = res.total_rows

    $scope.create = ->
      goal <- GoalService.create(planId: id, pos: $scope.num + 1).then
      $location.url "/goals/#{goal.id}"
