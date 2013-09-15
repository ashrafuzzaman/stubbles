//= require lib/fullcalendar
//= require notification

function loadCalendar(projectId, user_id) {
		$('#calendar').html('').fullCalendar({
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month'
		},
		theme: true,
		editable: true,
		events: "/projects/" + projectId + "/calendar/story_feed.json?user_id=" + user_id,
		eventDrop: function(event,dayDelta,minuteDelta,revertFunc) {
			var path = "/projects/" + projectId + "/stories/" + event.id + "/start_at";
			$.ajax({
				type: 'PUT',
			  dataType: "script",
			  url: path,
			  data: { dayDelta: dayDelta, minuteDelta: minuteDelta }
			});
		},
		eventResize: function(event,dayDelta,minuteDelta,revertFunc) {
    	var path = "/projects/" + projectId + "/stories/" 
    							+ event.id + "/complete_at";
			$.ajax({
				type: 'PUT',
			  dataType: "script",
			  url: path,
			  data: { dayDelta: dayDelta, minuteDelta: minuteDelta }
			});
  	},
		loading: function(bool) {
			if (bool) startLoading();
			else stopLoading();
		}
	});
}