class @Task
  @new: (task_elem) =>
    story_elem = task_elem.closest('.story')
    task_elem.find('.task-estimation').hide() if story_elem.attr('allow_to_estimate') == 'false'

$ ->
  $(document).on('template-rendered', '.tasks', (event, task) ->
    Task.new(task)
  )