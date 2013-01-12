$(document).ready(function() {

	$('tbody tr').popover({
		content: function() {
			return $($(this).attr("data-id")).html();
		},
		title: "Details",
		placement: "bottom",
		html: true
	});

});