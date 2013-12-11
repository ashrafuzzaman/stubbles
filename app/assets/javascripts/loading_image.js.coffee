LOADING_IMAGE_HTML = '<div class="ball"></div><div class="ball1"></div>'
$ ->
  $(document).on('ajax:beforeSend', '[show-loading-image]', (event, xhr, status) ->
    dom = $($(this).attr('show-loading-image'))
    dom.html(LOADING_IMAGE_HTML)
  )

  $(document).on('ajax:complete', '[show-loading-image]', (xhr, status) ->
    dom = $($(this).attr('show-loading-image'))
    dom.html('')
  )