class DashboardStoryMove
  @startMoving: =>
    $('*[show-on-story-move]').show()
    $('*[hide-on-story-move]').hide()
  @cancelMoving: =>
    $('*[show-on-story-move]').hide()
    $('*[hide-on-story-move]').show()
  @move: (milestoneId) =>
    serializedStoryIds = $('input[story-move-chk]').serialize()
    console.log(milestoneId, serializedStoryIds);
    @cancelMoving()

$ ->
  DashboardStoryMove.cancelMoving()
  $(document).on "click", "#move-story", ->
    DashboardStoryMove.startMoving()
  $(document).on "click", "#cancel-move-story", ->
    DashboardStoryMove.cancelMoving()
  $("select#move_milestone_id").change ->
    DashboardStoryMove.move($(this).val())