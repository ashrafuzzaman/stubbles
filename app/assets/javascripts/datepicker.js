//= require bootstrap-datetimepicker

$(document).on('focus', 'input.datepicker', function () {
    $(this).datetimepicker({
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        forceParse: 0,
        showMeridian: 1,
        format: 'mm/dd/yyyy'
    });
});

$(document).on('focus', 'input.date, input.datetimepicker', function () {
    $(this).datetimepicker({
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        forceParse: 0,
        showMeridian: 1
    });
});