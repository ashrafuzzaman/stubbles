class Guide
  constructor: ->
    @intro = introJs()
    @steps = []
  addStep: (selector, message, position) =>
    if $("#{selector}:visible").length > 0
      options = {
        element: document.querySelector(selector)
        intro: message}
      options['position'] = position if position

      @steps.push(options)
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
    guide.addStep('#dashboard_resources', "See the milestone details here", 'top')
    guide.addStep('.story_column', "The stories are listed here")
    guide.addStep('#involved_with', "Filter with user")
    guide.addStep('select#milestone_id', "Move between sprints")
    guide.addStep('#move-story',
      "Click Select stories then select milestone to copy or move and then select the action")
    guide

  @dashboardSelectStory: ->
    guide = new Guide
    guide.addStep('.story_column', "Select stories first")
    guide.addStep('select#action_milestone_id', "Select milestone to copy or move")
    guide.addStep('#story-action-dropdown', "Select action (move or copy)")
    guide.addStep('#cancel-move-story', "Or you can cancel the move/copy anytime")
    guide

@GuideFactory = GuideFactory

$ ->
  $(document).on('click', 'a[data-guide-name]', (event) ->
    event.stopPropagation()
    guideName = $(this).data('guide-name')
    GuideFactory.fetch(guideName).start() if guideName
  )