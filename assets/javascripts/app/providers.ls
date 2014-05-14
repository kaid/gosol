providers = angular.module \gosol.providers, <[goangular]>
root      = \https://goinstant.net/ae10d8f555c8/gosol

providers.config do
  ($goConnectionProvider)->
    $goConnectionProvider.$set root

providers.factory \ModelService do
  ($goKey, $goQuery)->
    (modelName, paramsbuilder)!->
      models = $goKey(modelName).$sync!

      @all   = -> models
      @where = (cond)-> $goQuery(modelName, cond, {}).$sync!
      @find  = (id)-> models.$key(id).$sync!
      @new   = (params)->
        models.$add paramsbuilder(params)


providers.factory \IdeaService do
  (ModelService)->
    {planId, name, desc, toplevel} <- new ModelService \ideas
    content: content
    type:    type

providers.factory \GoalService do
  (ModelService)->
    {planId, name, desc, toplevel} <- new ModelService \goals
    planId:   planId
    name:     name
    desc:     desc
    toplevel: toplevel

providers.factory \PlanService do
  (ModelService)->
    {planId, name, desc, toplevel} <- new ModelService \plans
    ideaId: ideaId
    goalId: goalId
