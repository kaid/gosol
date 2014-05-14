providers = angular.module \gosol.providers, <[goangular]>
root      = \https://goinstant.net/ae10d8f555c8/gosol

providers.config do
  [\$goConnectionProvider ($goConnectionProvider)->
    $goConnectionProvider.$set root
  ]

providers.service \IdeaService do
  ($goKey, $goQuery)!->
    ideas  = $goKey(\ideas).$sync!

    @all   = -> ideas
    @where = (cond)-> $goQuery(\ideas, cond, {}).$sync!
    @find  = (id)-> ideas.$key(id).$sync!
    @new   = ({content, type})->
      ideas.$add do
        content: content
        type:    type

providers.service \GoalService do
  ($goKey, $goQuery)!->
    goals  = $goKey(\goals).$sync!

    @all   = -> goals
    @where = (cond)-> $goQuery(\goals, cond, {}).$sync!
    @find  = (id)-> goals.$key(id).$sync!
    @new   = ({planId, name, desc, toplevel})->
      goals.$add do
        planId:   planId
        name:     name
        desc:     desc
        toplevel: toplevel

providers.service \PlanService do
  ($goKey, $goQuery)!->
    plans  = $goKey(\plans).$sync!

    @all   = -> plans
    @where = (cond)-> $goQuery(\plans, cond, {}).$sync!
    @find  = (id)-> plans.$key(id).$sync!
    @new   = ({ideaId, goalId})->
      plans.$add do
        ideaId: ideaId
        goalId: goalId
