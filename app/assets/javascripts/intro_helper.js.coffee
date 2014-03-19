class Guide
  constructor: ->
    @intro = introJs()
    @steps = []
  addStep: (selector, message) =>
    @steps.push({
        element: document.querySelector(selector)
        intro: message}
    )
  start: ->
    @intro.setOptions({ steps: @steps })
    @intro.start()

@Guide = Guide

class GuideFactory
  @fetch: (guide_name) ->
    eval "GuideFactory.#{guide_name}()"

  @dashboard: ->
    guide = new Guide
    guide.addStep('#new-story', "New story button")
    guide

@GuideFactory = GuideFactory