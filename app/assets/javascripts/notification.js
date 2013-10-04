//= require jquery.bootstrap-growl

function showMessage(message) {
    $("#dialog").html(message).dialog();
}

function hideSlidingMessage() {
    $.noty.close()
}

function showSlidingMessage(message, type) {
    $.bootstrapGrowl(message, {
        type: type, // (null, 'info', 'error', 'success')
        allow_dismiss: true,
        stackup_spacing: 10 // spacing between consecutively stacked growls.
    });
}

function showSuccessMessage(message) {
    showSlidingMessage(message, 'success');
}

function showErrorMessage(message) {
    showSlidingMessage(message, 'error');
}