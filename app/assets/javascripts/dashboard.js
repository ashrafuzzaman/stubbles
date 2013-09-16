//= require tag.js

var SORTABLE_COLUMN_SELECTOR = ".story_column";
var PROJECT_ID = window.location.pathname.split('/')[2]; //expecting the pathname as /projects/1/dashboard

$(function () {
    $(SORTABLE_COLUMN_SELECTOR).sortable({
        connectWith: SORTABLE_COLUMN_SELECTOR,
        forcePlaceholderSize: true,
        handle: '.portlet-header',
        stop: function (event, ui) {
            var scope = ui.item.closest(SORTABLE_COLUMN_SELECTOR).attr('data-scope');
            var storyElem = ui.item;
            var storyId = storyElem.attr("id").replace('story-', '');
            var nextStoryElem = storyElem.next(".story");
            var nextStoryId = nextStoryElem.length == 0 ? 0 : nextStoryElem.attr("id").replace('story-', '');

            var changes = {
                "scope": scope,
                "story_id": storyId,
                "shift_from_story_id": nextStoryId
            }
            updateChanges(changes);
        }
    });
    $(SORTABLE_COLUMN_SELECTOR).each(function (index) {
        update_chached_order_for($(this));
    });

    $("#toggleCollapse").click(function () {
        toggleCollapse();
    });

    updateStoryWidget(true);
    addWidgetsCollapsable();
    $("body").ajaxStop(function () {
        updateStoryWidget(false);
    });
    $(".comments .portlet-content").hide();
});

function updateStoryWidget(collapse) {
    $(".story_type").buttonset().removeClass("story_type");
}

function updateChanges(changes) {
    if (!did_order_changed_for(changes["scope"])) return;

    startLoading();
    $.post("/projects/" + PROJECT_ID + "/stories/update_scope_and_priority",
            changes
        ).complete(function () {
            stopLoading();
        });
}

function did_order_changed_for(scope) {
    sortableCol = $('div[data-scope="' + scope + '"]').first();
    if (sortableCol.sortable('toArray').join() == sortableCol.data("order")) {
        return false;
    } else {
        update_chached_order_for(sortableCol);
        return true;
    }
}

function update_chached_order_for(sortableCol) {
    sortableCol.data("order", sortableCol.sortable('toArray'));
}

function toggleCollapse() {
    $(".portlet-header .collapsable").click();
}

function addWidgetsCollapsable() {
    var expand_class = "ui-icon-triangle-1-n";
    var collapse_class = "ui-icon-triangle-1-s";
    var init_class = collapse_class;

    $(document).on('click', ".story-header .collapsable", function () {
        console.log('Story', $(this));
        var element = $(this);
        console.log('element', element);
        element.toggleClass(collapse_class).toggleClass(expand_class);
        element.parents(".story:first").find(".story-content").toggle("fast");
    });

    $(document).on('click', ".comments-header", function () {
        var element = $(this);
        element.find(".collapsable").toggleClass(collapse_class).toggleClass(expand_class);
        element.parents(".comments:first").find(".comments-content").toggle("fast");
    });

    $(SORTABLE_COLUMN_SELECTOR).each(function (index) {
        update_chached_order_for($(this));
    });
}