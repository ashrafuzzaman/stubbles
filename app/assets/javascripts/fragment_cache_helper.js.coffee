class @Menu
  @markActive: (title) =>
    nav = $(".navbar .nav")
    nav.find("li").removeClass('active')
    nav.find("li:contains('#{title}')").addClass('active')
  @init: =>
    path = window.location.pathname
    path_regex_list = [
      [/\/projects\/\d+\/dashboard/, 'Dashboard'],
      [/\/projects$/, 'Projects'],
      [/\/projects\/\d+\/milestones/, 'Milestones'],
      [/\/projects\/\d+\/weekly_time_entry/, 'Time entry']
    ]
    for path_regex in path_regex_list
      if path_regex[0].test path
        @markActive(path_regex[1])

$ ->
  Menu.init()
#  $(document).ajaxComplete((event, xhr, settings) ->
#  )