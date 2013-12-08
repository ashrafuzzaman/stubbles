class @RenderTemplateOnEvent
  @show: (elem) =>
    templateName = elem.attr('render-template')
    html = Template.render($("##{templateName}").html(), elem.data())
    rootElement = elem.attr('append-after')
    htmlDom = $(html)
    $(rootElement).append(htmlDom)
    htmlDom.hide().slideDown()

$(document).ready(->
  $(document).on('click', '[render-template]', ->
    event = $(this).attr('event') || 'click'
    if event == 'click'
      RenderTemplateOnEvent.show($(this));
  )
)