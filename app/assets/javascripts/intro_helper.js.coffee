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
    guide.addStep('#new-story', "Click here to create new story or issue")
    guide.addStep('#dashboard_resources', "See the milestone details here")
    guide.addStep('.story_column', "The stories are listed here")
    guide.addStep('#involved_with', "Filter with user")
    guide.addStep('select#milestone_id', "Move between sprints")
    guide.addStep('#move-story', "Click Select stories then select milestone to copy or move and then select the action")
    guide

@GuideFactory = GuideFactory

$ ->
  $(document).on('click', 'a[data-guide-name]', (event) ->
    event.stopPropagation()
    guideName = $(this).data('guide-name')
    GuideFactory.fetch(guideName).start() if guideName
  )