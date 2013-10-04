#= require jquery.bootstrap-growl

class @Message
  @show: (message, type) =>
    $.bootstrapGrowl(message, {
      type: type, # (null, 'info', 'danger', 'success')
      allow_dismiss: true,
      stackup_spacing: 10 # spacing between consecutively stacked growls
    })

  @successMessage: (message) =>
    @show(message, 'success')

  @errorMessage: (message) =>
    @show(message, 'danger')