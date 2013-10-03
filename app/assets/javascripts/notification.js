//= require jquery.pnotify

function showMessage(message) {
    $("#dialog").html(message).dialog();
}

function hideSlidingMessage() {
    $.noty.close()
}

function showSlidingMessage(message, type) {
//	noty({text: message, type: type, layout: 'topRight'});
    $.pnotify({text: message, type: type, layout: 'topRight'});
}

function showSuccessMessage(message) {
    showSlidingMessage(message, 'success');
}

function showErrorMessage(message) {
    showSlidingMessage(message, 'error');
}