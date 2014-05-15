require \angular
require \angular-route
require \angular-pouchdb

require \./providers
require \./controllers

templates = require \templates

app = angular.module \gosol <[ngRoute gosol.controllers]>

app.config do
  [\$routeProvider ($routeProvider)->
    $routeProvider
      .when \/ do
        template: templates[\toplevel]
        controller: \ToplevelIndex
      .when \/ideas do
        template: templates[\ideas/index]
        controller: \IdeasIndex
      .when \/ideas/new do
        template: templates[\ideas/new]
        controller: \IdeasNew
      .when \/ideas/:id do
        template: templates[\ideas/edit]
        controller: \IdeasEdit
      .when \/goals/new do
        template: templates[\goals/new]
        controller: \GoalsNew
      .when \/goals/:id do
        template: templates[\goals/edit]
        controller: \GoalsEdit
      .when \/plans/:id do
        template: templates[\plans/edit]
        controller: \PlansEdit
      .otherwise do
        redirectTo: \/
  ]
