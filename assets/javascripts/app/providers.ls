providers = angular.module \gosol.providers <[pouchdb]>

providers.factory \GosolDb (pouchdb)->
  pouchdb.create(\gosol)

providers.factory \ModelService (GosolDb)->
  (collectionName, propsBuilder)!->
    @where  = (cond)->
      map = (doc, emit)-> emit(doc) if cond(doc) && doc.$collection == collectionName
      GosolDb.query({map: map} {reduce: false})

    @all = -> 
      @where (doc)-> doc.$collection == collectionName

    @find = (id)->
      GosolDb.get(id)

    @create = (params)->
      props = propsBuilder(params)
      props.$collection = collectionName
      GosolDb.post props

    @update = (entity)->
      GosolDb.put entity

providers.factory \IdeaService do
  (ModelService)->
    {content, type, goalId} <- new ModelService \ideas
    content: content
    type:    type
    goalId:  goalId

providers.factory \GoalService do
  (ModelService)->
    {planId, name, desc, toplevel, pos} <- new ModelService \goals
    planId:   planId
    name:     name
    desc:     desc
    toplevel: toplevel
    pos:      pos

providers.factory \PlanService do
  (ModelService, IdeaService)->
    {ideaId, goalId, name} <- new ModelService \plans
    ideaId: ideaId
    goalId: goalId
    name:   name
