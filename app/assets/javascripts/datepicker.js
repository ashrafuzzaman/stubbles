//= require bootstrap-datepicker

$(document).on('focus', 'input.datepicker', function () {
    $(this).datepicker({
        format: 'yyyy-mm-dd'
    });
});