//= require lib/tag-it.js

$(function() {
	attach_tag();	
	$("body").ajaxStop(function(){
		attach_tag();
	});
});

function attach_tag() {	
	$(".tag-it").each(function(i){
		var availableTags = ($(this).data('available-tags') || []).toString().split(',');
		var itemName = $(this).data('item-name');
		var fieldName = $(this).data('field-name');
		$(this).tagit({ 
			itemName: itemName,
			fieldName: fieldName,
			availableTags: availableTags
		}).removeClass("tag-it").append(
			'<input type="hidden" style="display:none;" value="" ' 
				+ 'name="' + itemName + '[' + fieldName + '][]">');
				//this is done so that when there is no tags, 
				// then there is a default empty tag so that the tags get cleared
	});
}