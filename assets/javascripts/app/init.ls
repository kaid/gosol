require \angular
require \angular-route
require \./controllers

templates = require \templates

app = angular.module \gosol <[ngRoute gosol.controllers]>

app.config do
  [\$routeProvider ($routeProvider)->
    $routeProvider
      .when \/ideas do
        template: templates.ideas
        controller: \IdeasController
      .when \/ideas/:id do
        template: templates.idea
        controller: \IdeaController
      .when \/goals do
        template: templates.goals
        controller: \GoalsController
      .when \/goals/:id do
        template: templates.goal
        controller: \GoalController
      .otherwise do
        redirectTo: \/goals
  ]
