//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require notification
//= require ajax_loader
//= require lib/jquery.cleditor.js
//= require lib/jquery.ui.selectmenu

$(function() {
	addSubmitalbeElemntInForm();
	attachCancelSupport();

	$('body').on('ready', 'input.date', function() {
		$(this).datepicker();
	});

	$('.richtext').cleditor({useCSS:true});

	initializeDom();
	$("body").ajaxStop(function(){
		initializeDom();
	});
	$('select.selectUser').selectmenu({style:'popup', width: 200});
});

function initializeDom() {
	addRichText();
	addUIButton();
}

function addUIButton() {
	$('.button').button();
	$('.button').removeClass('button');
}

function addSubmitalbeElemntInForm() {
	$('body').on('change', '.submittable', function() {
		$(this).parents('form:first').submit();
	});
}

function attachCancelSupport(){
	$('body').on('click', 'a[data-cancel]',
		function(){
			var elementToClose = $(this).attr("data-cancel");
			$(this).closest(elementToClose).slideUp('fast', function() {
    			$(this).remove();
			});
		}
	);
}

function addRichText() {
  $(".richtext").cleditor({width:440, height:180, useCSS:true})[0];
  $(".richtext").removeClass("richtext");
}