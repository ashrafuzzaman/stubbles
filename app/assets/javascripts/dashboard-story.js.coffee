class @Dashboard
  @PROJECT_ID = window.location.pathname.split('/')[2]; #expecting the pathname as /projects/1/dashboard

class DashboardStoryAction
  @reinitialize: =>
    if($("#move-story").is(":visible"))
      @cancelMoving()
    else
      @startMoving()

  @startMoving: =>
    $('*[hide-on-story-select]').hide()

    $('*[show-on-story-select]').show()

  @cancelMoving: =>
    $('*[show-on-story-select]').hide()
    $('*[hide-on-story-select]').show()

  @milestoneBatchAction: (action) =>
    milestoneId = $("#action_milestone_id").val()
    console.log(milestoneId);
    storyIds = []
    $('input[story-move-chk]:checked').each ->
      storyIds.push($(this).val());

    fromMilestoneId = $("#milestone_id").val()
    $.ajax "/projects/#{Dashboard.PROJECT_ID}/milestones/#{action}",
      type: "PUT"
      data: { milestone_id: milestoneId, from_milestone_id: fromMilestoneId, story_ids: storyIds }
      dataType: 'script'
      success: ->
        $("select#action_milestone_id").val($("select#action_milestone_id").data('selected'));
    @cancelMoving()

  @move: () =>
    @milestoneBatchAction('move_stories')
  @copy: () =>
    @milestoneBatchAction('copy_stories')

$ ->
  DashboardStoryAction.cancelMoving()
  $(document).on "click", "#move-story", ->
    DashboardStoryAction.startMoving()
  $(document).on "click", "#cancel-move-story", ->
    DashboardStoryAction.cancelMoving()
  $(document).on('click', "#move-story-action", ->
    DashboardStoryAction.move()
  )
  $(document).on('click', "#copy-story-action", ->
    DashboardStoryAction.copy()
  )

  $(document).on('click', '[select-all]', ->
    $($(this).attr('select-all')).find('input[type="checkbox"]').prop('checked', true)
  )
  $(document).on('click', '[select-none]', ->
    $($(this).attr('select-none')).find('input[type="checkbox"]').prop('checked', false)
  )

@DashboardStoryAction = DashboardStoryAction