//= require dashboard-story

var SORTABLE_COLUMN_SELECTOR = ".story_column";
var SORTABLE_HANDLER_SELECTOR = ".story-header";
var PROJECT_ID = window.location.pathname.split('/')[2]; //expecting the pathname as /projects/1/dashboard

$(function () {
    $(SORTABLE_COLUMN_SELECTOR).sortable({
        connectWith: SORTABLE_COLUMN_SELECTOR,
        forcePlaceholderSize: true,
        handle: SORTABLE_HANDLER_SELECTOR,
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
});

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