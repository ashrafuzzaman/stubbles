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
  @fetch: (guideName) ->
    eval "GuideFactory.#{guideName}()"

  @dashboard: ->
    guide = new Guide
    guide.addStep('#new-story', "New story button")
    guide

@GuideFactory = GuideFactory

$ ->
  $(document).on('click', 'a[data-guide-name]', (event) ->
    event.stopPropagation()
    guideName = $(this).data('guide-name')
    GuideFactory.fetch(guideName).start() if guideName
  )