class GosolCanvas
  (@scope, @$el)->
    @mheight  = 80
    @width    = 960
    @duration = 400
    @bheight  = 48
    @bwidth   = 900
    @margin   = 20
    @i        = 0

    @setup!

  setup: ->
    that = @

    @dispatcher = d3.dispatch(\nodeReady)
    @tree = d3.layout.tree!.nodeSize([0, @bheight])
    @diagonal = d3.svg.diagonal!.projection((d)-> [d.y, d.x + 20])
    @canvas = d3.select(@$el[0]).append(\svg)
                .attr(\width @$el.width!)
                .attr(\height @$el.height!)
                .append(\g)
                .attr(\transform "translate(20,20)")

    @dispatcher.on \nodeReady (node, d)->
      gLabel = node.find(\.node-label)
      gBody  = node.find(\.node-body)

      labelWidth = gLabel.find(\text)[0].getComputedTextLength!
      bodyWidth  = gBody.find(\text)[0].getComputedTextLength!

      gLabel.find(\rect).attr(\width, labelWidth + 64)
      gBody.find(\rect).attr(\width, bodyWidth + 36)

      return if d.root
      gBody.attr(\transform "translate(#{labelWidth + 18},0)")

    @root = @scope.root
    @update(@root)
    @getChildren(@root)

  getChildren: (d)->
    that = @

    func = switch d.$collection
    | \root     => d.goals
    | \goals    => d.ideas
    | \ideas    => d.plans
    | \plans    => d.goals
    | otherwise => (fn)-> fn(d)

    func.call d, (children)->
      d.children = if d.collapsed then null else children
      that.update(d)
      
  getText: (d)->
    switch d.$collection
    | \root     => d.name
    | \goals    => d.name
    | \ideas    => d.content
    | \plans    => d.name
    | otherwise => null

  resize: ->
    that = @

    @height = Math.max @mheight, @nodes.length * @bheight + 25

    d3.select(@$el.find(\svg)[0])
      .transition!
      .duration(@duration)
      .attr(\height @height)

    @nodes.forEach (node, index)->
      node.x = that.bheight * index

  clickNode: ->
    that = @

    (d)->
      d.collapsed = if d.collapsed then false else true
      that.getChildren(d)

  updateLabel: (node)->
    label = node.append(\g)
                .attr(\class \node-label)
                .style(\display (d)->
                  if d.root then "none" else null)

    label.append(\rect)
         .attr(\rx 20)
         .attr(\width 240)
         .attr(\height @bheight - 8)
         .style(\fill \#ccc)

    label.append(\text)
         .attr(\text-rendering \geometricPrecision)
         .attr(\dx 12)
         .text((d)-> d.$collection)
         .attr(\dy -> 25) 

  updateNode: (src)->
    that = @

    node = @canvas.selectAll(\g.node)
                  .data(@nodes, (d)->
                    d.id || (d.id = ++that.i))

    enter = node.enter!.append(\g)
                .attr(\class \node)
                .attr(\transform (d)-> "translate(#{src.y0}, #{src.x0})")

    enter.on(\click @clickNode!)

    @updateLabel(enter)

    body = enter.append(\g).attr(\class \node-body)

    body.append(\rect)
         .attr(\rx 20)
         .attr(\width @bwidth)
         .attr(\height @bheight - 8)


    body.append(\text)
         .attr(\dy 26)
         .attr(\dx 16)
         .text(@getText)
         .attr(\text-rendering (d)->
           that.dispatcher.nodeReady($(this).closest(\.node), d)
           \geometricPrecision)

    enter.transition!
         .duration(@duration)
         .attr(\transform (d)-> "translate(#{d.y},#{d.x})")
         .style(\opacity 1)

    node.transition!
        .duration(@duration)
        .attr(\transform (d)-> "translate(#{d.y},#{d.x})")
        .style(\opacity 1)

    node.exit!
        .transition!
        .duration(@duration)
        .attr(\transform (d)-> "translate(#{src.y},#{src.x})")
        .style(\opacity 0)
        .remove!

  updateLink: (src)->
    that = @

    link = @canvas.selectAll(\path.link)
                  .data(@tree.links(@nodes), (d)->
                    d.target.id)

    link.enter!
        .insert(\path, \g)
        .attr(\class \link)
        .attr(\d (d)->
          o = x: src.x0, y: src.y0
          that.diagonal(source: o, target: o))
        .transition!
        .duration(@duration)
        .attr(\d that.diagonal)

    link.transition!
        .duration(@duration)
        .attr(\d that.diagonal)

    link.exit!
        .transition!
        .duration(@duration)
        .attr(\d (d)->
          o = x: src.x, y: src.y
          that.diagonal(source: o, target: o))
        .remove!

  update: (src)->
    @nodes = @tree.nodes(@root)
    @resize!
    @updateNode(src)
    @updateLink(src)

    @nodes.forEach (d)->
      d.x0 = d.x
      d.y0 = d.y


lib = angular.module \gosol.lib <[]>

lib.value \GosolCanvas GosolCanvas
