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
//= require loading_image
//= require intro

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

function parseURL(url) {
    var a = document.createElement('a');
    a.href = url;
    var urlHash = {
        source: url,
        protocol: a.protocol.replace(':', ''),
        host: a.hostname,
        port: a.port,
        query: a.search,
        params: (function () {
            var ret = {},
                seg = a.search.replace(/^\?/, '').split('&'),
                len = seg.length, i = 0, s;
            for (; i < len; i++) {
                if (!seg[i]) {
                    continue;
                }
                s = seg[i].split('=');
                ret[s[0]] = s[1];
            }
            return ret;
        })(),
        file: (a.pathname.match(/\/([^\/?#]+)$/i) || [, ''])[1],
        hash: a.hash.replace('#', ''),
        path: a.pathname.replace(/^([^\/])/, '/$1'),
        relative: (a.href.match(/tps?:\/\/[^\/]+(.+)/) || [, ''])[1],
        segments: a.pathname.replace(/^\//, '').split('/')
    };
    a.remove();
    return urlHash;
}

function parseCurrentURL() {
    return parseURL(document.URL);
}