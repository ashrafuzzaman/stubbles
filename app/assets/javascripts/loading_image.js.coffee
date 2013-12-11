LOADING_IMAGE_HTML = '<img src="/assets/ajax-loader.gif" alt="Loading ..." class="loading-image">'
$ ->
  $(document).on('ajax:beforeSend', '[show-loading-image]', (event, xhr, status) ->
    dom = $($(this).attr('show-loading-image'))
    dom.html(LOADING_IMAGE_HTML)
  )

  $(document).on('ajax:complete', '[show-loading-image]', (xhr, status) ->
    dom = $($(this).attr('show-loading-image'))
    dom.html('')
  )