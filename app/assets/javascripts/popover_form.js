var popover_form_selector = '[popup-form]';
var PopOverForm = {
    destroyAndReload: function () {
        PopOverForm.destroyAllPopupHover();
        PopOverForm.initializePopover();
    },

    destroyAllPopupHover: function () {
        $(popover_form_selector).popover('hide'); //for now hide all
    },

    initializePopoverFor: function ($this) {
        var content = PopOverForm.render($this);
        var contentHtml = $('<div></div>').html(content);
        var title = $this.closest('[popup-title]').attr('popup-title');
        $this.attr('data-title', title);
        $this.attr('data-content', contentHtml.html());
        $this.popover({trigger: 'manual',
            html: true,
            placement: function (pop, dom_el) {
                var width = window.innerWidth;
                var left_pos = $(dom_el).offset().left;
                if (left_pos / width > .5) return 'left';
                return 'right';
            }
        });
    },

    initializePopover: function () {
        $(popover_form_selector).each(function () {
            PopOverForm.initializePopoverFor($(this));
        });
    },

    render: function (elem) {
        var template_values = {};
        attributes = elem[0].attributes;
        aLength = attributes.length;
        for (a = 0; a < aLength; a++) {
            template_values[attributes[a].name] = attributes[a].value;
        }
        var template_selector = "#" + elem.closest('[popup-template]').attr('popup-template');
        var html = Template.render($(template_selector).html(), template_values);
        return html;
    }

}

$(document).ready(function () {
//    Form.interceptForAjax();
    PopOverForm.initializePopover();

    $(popover_form_selector).on('click', function () {
        $(this).popover('toggle');
        $("input[auto-focus]").focus();
    });

    $(document).on('click', 'a[close-pophover]', function () {
        PopOverForm.destroyAllPopupHover();
    });

    // press esc to hide
    $(document).keydown(function (e) {
        if (e.keyCode == 27) {
            PopOverForm.destroyAllPopupHover();
        }
    });

});