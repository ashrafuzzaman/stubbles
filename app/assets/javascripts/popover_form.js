var popover_form_selector = '[popup-form]';
var PopOverForm = {
    destroyAllPopupHover: function () {
        $('[popup-form][data-content]').popover('destroy'); //for now hide all
        $('[popup-form]').removeAttr('data-content');
        $('.popover').remove();
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
    $(document).on('click', popover_form_selector, function () {
        var content = $(this).attr('data-content');
        console.log($(this));
        if (typeof content == 'undefined' || content == '') {
            PopOverForm.initializePopoverFor($(this));
        }
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