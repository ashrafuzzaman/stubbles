$(function() {
	$(document).on('click', ".editable:not(.editing)", 
		function() {
			makeEditable($(this));
		}
	);

});

function makeEditable(element) {
	var prevValue = element.html();
	var editableElement = '<input type="text" class="inline_editor" size="2"' +
												'value="' + prevValue + '"></input>';
	element.addClass("editing").html('').append(editableElement);

	element.keydown(function(e) {
    if (e.keyCode == 27) { // ESCAPE key pressed
        doneEditing(element, prevValue);
    } else if(e.keyCode == 13) { //Enter keycode
    	var newValue = element.find(".inline_editor").val();
			postValue(element, newValue);
		}
	});
}

function postValue(element, value) {
	element.data("value", value);
	var data = element.data();
	var projectId = element.data("project-id");
	var url = "/projects/" + projectId + "/update_time_entry";

	$.ajax({
	  type: 'POST',
	  url: url,
	  data: data,
	  dataType: "script"
	});
	doneEditing(element, value);
}

function doneEditing(element, value) {
	element.removeClass("editing").html(value);
}