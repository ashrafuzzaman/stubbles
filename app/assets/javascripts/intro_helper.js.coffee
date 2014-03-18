class Guide
  @addStep: (locator, message) =>
    nav = $(".navbar .nav")
    nav.find("li").removeClass('active')
    nav.find("li:contains('#{title}')").addClass('active')

@Guide = Guide