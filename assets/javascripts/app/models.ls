Models = (GoalService, IdeaService, PlanService)->
  Root = do
    collapsed: false
    name: \root
    $collection: \root
    x0: 0
    y0: 0

  Root.goals = (fn)->
    Goal.where ((doc)-> doc.toplevel), fn

  class Base
    @service

    @collectionRes = (res)->
      that = @

      res.rows.map (item)->
        new that(item.key)

    @where = (cond, fn)-> 
      that = @

      @service.where(cond).then (res)->
        fn(that.collectionRes(res))

    @all = (fn)->
      that = @

      @service.all!.then (res)->
        fn(that.collectionRes(res))

    @find = (id, fn)->
      that = @

      @service.find(id).then (res)->
        fn(new that(res))

    collapsed: true


  class Goal extends Base
    @service = GoalService

    ({@planId, @name, @desc, @toplevel, @pos, @_id})->

    $collection: \goals

    ideas: (fn)->
      that = @

      Idea.where ((doc)-> doc.goalId == that._id), (res)->
        fn(res)

  class Idea extends Base
    @service = IdeaService

    ({@content, @type, @goalId, @_id})->

    $collection: \ideas

    plans: (fn)->
      that = @

      Plan.where ((doc)-> doc.ideaId == that._id), (res)->
        fn(res)

  class Plan extends Base
    @service = PlanService

    ({@ideaId, @goalId, @name, @_id})->

    $collection: \plans

    goals: (fn)->
      that = @

      Goal.where ((doc)-> doc.planId == that._id), (res)->
        fn(res)

  Root: Root
  Goal: Goal
  Idea: Idea
  Plan: Plan

models = angular.module \gosol.models <[gosol.providers]>

models.factory \Models Models

models.factory \Root (Models)->
  Models.Root 

models.factory \Goal (Models)->
  Models.Goal 

models.factory \Idea (Models)->
  Models.Idea

models.factory \Plan (Models)->
  Models.Plan
