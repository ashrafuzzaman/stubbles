class @Dashboard
  @PROJECT_ID = window.location.pathname.split('/')[2]; #expecting the pathname as /projects/1/dashboard

class DashboardStoryMove
  @reinitialize: =>
    if($("#move-story").is(":visible"))
      @cancelMoving()
    else
      @startMoving()

  @startMoving: =>
    $('*[show-on-story-move]').show()
    $('*[hide-on-story-move]').hide()

  @cancelMoving: =>
    $('*[show-on-story-move]').hide()
    $('*[hide-on-story-move]').show()

  @move: (milestoneId) =>
    storyIds = []
    $('input[story-move-chk]:checked').each ->
      storyIds.push($(this).val());

    console.log(milestoneId, storyIds);
    $.ajax "/projects/#{Dashboard.PROJECT_ID}/milestones/move_stories",
      type: "PUT"
      data: { milestone_id: milestoneId, story_ids: storyIds }
      dataType: 'script'

    @cancelMoving()

$ ->
  DashboardStoryMove.cancelMoving()
  $(document).on "click", "#move-story", ->
    DashboardStoryMove.startMoving()
  $(document).on "click", "#cancel-move-story", ->
    DashboardStoryMove.cancelMoving()
  $("select#move_milestone_id").change ->
    DashboardStoryMove.move($(this).val())

@DashboardStoryMove = DashboardStoryMove