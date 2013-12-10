class @RenderTemplateOnEvent
  @show: (elem) =>
    templateName = elem.attr('render-template')
    template = $("##{templateName}").html()
    if template == null
      console.error("#{templateName} template is missing")
      return

    html = Template.render($("##{templateName}").html(), elem.data())
    rootElement = elem.attr('append-after') || elem.attr('prepend-after')
    htmlDom = $(html)
    if elem.attr('append-after')
      $(rootElement).append(htmlDom)
    else
      $(rootElement).prepend(htmlDom)

    $(rootElement).trigger("template-rendered")
    $(document).trigger("template-rendered", [rootElement])
    htmlDom.hide().slideDown()

$(document).ready(->
  $(document).on('click', '[render-template]', ->
    event = $(this).attr('event') || 'click'
    if event == 'click'
      RenderTemplateOnEvent.show($(this));
  )
)