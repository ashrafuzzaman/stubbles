class DashboardStoryMove
  @startMoving: =>
    $('*[show-on-story-move]').show()
    $('*[hide-on-story-move]').hide()
  @cancelMoving: =>
    $('*[show-on-story-move]').hide()
    $('*[hide-on-story-move]').show()
  @move: =>
    milestoneId = $('#move_milestone_id').val()
    serializedStoryIds = $('[name=story-move-chk]').serialize()
    console.log(milestoneId);
    @cancelMoving()

$ ->
  DashboardStoryMove.cancelMoving()
  $(document).on "click", "#move-story", ->
    DashboardStoryMove.startMoving()
  $(document).on "click", "#cancel-move-story", ->
    DashboardStoryMove.cancelMoving()
  $(document).on "click", "#done-move-story", ->
    DashboardStoryMove.move()