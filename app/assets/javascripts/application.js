//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require notification
//= require ajax_loader
//= require lib/jquery.ui.selectmenu
//= require bootstrap
//= require bootstrap-wysihtml5/b3
//= require bootstrap-tagsinput
//= require dashboard
//= require datepicker
//= require dashboard-story

$(function () {
    addSubmitalbeElemntInForm();
    attachCancelSupport();

    initializeDom();
    $("body").ajaxStop(function () {
        initializeDom();
    });
    $('select.selectUser').selectmenu({style: 'popup', width: 200});
});

function initializeDom() {
    addRichText();
    addUIButton();
    //binding tags
    $('input[data-role="tagsinput"]').tagsinput();
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
    $('body').on('click', 'a[data-cancel]',
        function () {
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