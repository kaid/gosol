app, templates <- define <[app templates]>

app.config [\$routeProvider ($routeProvider)->
  $routeProvider
    .when \/goals do
      template: templates.goal_list
      controller: \GoalListController
    .when \/goals/:id do
      template: templates.goal
      controller: \GoalController
    .otherwise do
      redirectTo: \/goals
]
