//= require jquery_ujs
//= require notification
//= require ajax_loader
//= require bootstrap-wysihtml5/b3
//= require bootstrap-tagsinput
//= require datepicker
//= require jquery_nested_form
//= require template
//= require popover_form
//= require fragment_cache_helper
//= require jquery.remotipart
//= require render_on_event

$(function () {
    addSubmitalbeElemntInForm();
    attachCancelSupport();

    initializeDom();
    $("body").ajaxStop(function () {
        initializeDom();
    });

    $(document).on('template-rendered', function (e, dom) {
        initializeDom()
    });
});

function initializeDom() {
    addRichText();
    addUIButton();
    //binding tags
    $('input[data-role="tagsinput"]').each(function () {
        $(this).tagsinput();
        $(this).removeAttr('data-role');
    });
}

function addUIButton() {
    $('.button').button();
    $('.button').removeClass('button');
}

function addSubmitalbeElemntInForm() {
    $('body').on('change', '.submittable', function () {
        $(this).parents('form:first').submit();
    });
}

function attachCancelSupport() {
    $('body').on('click', 'a[data-cancel]', function () {
            var elementToClose = $(this).attr("data-cancel");
            $(this).closest(elementToClose).slideUp('fast', function () {
                $(this).remove();
            });
        }
    );
}

function addRichText() {
    $('.richtext').each(function (i, elem) {
        $(elem).wysihtml5();
    });
    $(".richtext").removeClass("richtext");
}