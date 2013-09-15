//= require lib/jquery.noty

$(function() {
	$("#notice").on('click', function() {
		hideSlidingMessage();
	});

	// press ESCAPE key to hide the message
	$(document).keydown(function(e) {
    if (e.keyCode == 27) { 
      hideSlidingMessage();
    }
	});

});

function showMessage(message){
	$("#dialog").html(message).dialog();
}

function hideSlidingMessage(){
	$.noty.close()
}

function showSlidingMessage(message, type){
	noty({text: message, type: type, layout: 'topRight'});
}

function showSuccessMessage(message){
	showSlidingMessage(message, 'success');
}

function showErrorMessage(message){
	showSlidingMessage(message, 'error');
}