$(function() {
	$("#loading").hide();
	attachAjaxLoading();
});

function attachAjaxLoading(){
	//this is a global handler that stop is there is any loading going on
	$('body').on('ajaxComplete', function() {
		stopLoading();
	});
	$('body').on('ajax:before',
	  'a[data-start-loading="true"], form[data-start-loading="true"]',
	  function(e, data, textStatus, jqXHR){
	    startLoading();
	  }
	);
}

function startLoading(){
	$("#loading").dialog({ 
		modal: true,
		resizable: false,
		closeOnEscape: true,
		width: 260,
		height: 80
	});
}

function stopLoading(){
	$("#loading").dialog("close");
}