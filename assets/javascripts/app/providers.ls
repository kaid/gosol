providers = angular.module \gosol.providers <[pouchdb]>

providers.factory \GosolDb (pouchdb, remote)->
  name = \gosol
  db = pouchdb.create(name)
  db.replicate.sync(remote)
  db

providers.value \remote "http://kaid.iriscouch.com:5984/gosol"

providers.factory \ModelService (GosolDb, remote)->
  (collectionName, propsBuilder)!->
    @where  = (cond)->
      map = (doc, emit)-> emit(doc) if cond(doc) && doc.$collection == collectionName
      GosolDb.query({map: map} {reduce: false})

    @all = -> 
      @where (doc)-> doc.$collection == collectionName

    @find = (id)->
      GosolDb.get(id)

    @create = (params)->
      props.$collection = collectionName
      promise = GosolDb.post propsBuilder(params)
      GosolDb.replicate.sync(remote)
      promise

    @update = (params)->
      promise = GosolDb.put propsBuilder(params)
      GosolDb.replicate.sync(remote)
      promise

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
