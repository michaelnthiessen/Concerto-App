$(document).ready(function() {

	// We keep track of the data-id of the currently open popover
	var currPopoverID = null;
	var currRow = null;

	// Called to bind the popover event to the table rows
	$('tbody tr').popover({
		trigger: 'manual',
		content: function() {
			return $($(this).attr("data-id")).html();
		},
		title: "<span>Details</span> <a class='pull-right close-popover' href='#'>Close</a>",
		placement: "bottom",
		html: true
	});

	// Bind a click event to the concerts
	$('tbody tr').click(function(event) {

		// Prevent the event from propagating upwards
		event.stopPropagation();

		// If we click on the same concert, close it
		if (currPopoverID == $(this).attr('data-id')) {
			$(this).popover('hide');
			currRow.removeClass('highlight');
			currPopoverID = null;
			currRow = null;
		}
		// If its a different concert, close whichever is open
		else {

			// If one is currently popped, close it
			if (currPopoverID) {
				$("[data-id="+currPopoverID+"]").popover('hide');
				currRow.removeClass('highlight');
			}

			// Open the current one, and set it to the current one
			$(this).popover('show');
			currPopoverID = $(this).attr("data-id");
			currRow = $(this);

			// Bind our click event
			$('a.close-popover').click(function(event) {
				event.preventDefault();
				event.stopPropagation();
				$("[data-id="+currPopoverID+"]").popover('hide');
				currRow.removeClass('highlight');
				currRow = null;
				currPopoverID = null;
			});

			// Set the class to highlight the table row
			$(this).addClass("highlight");
		}
	});

	// Handles when the user clicks outside of the popup
	$(document).click(function(event) {

		if($(event.target).is(".popover, .popover *")) {
			event.stopPropagation();
		}
		else {
			$("[data-id="+currPopoverID+"]").popover('hide');
			currRow.removeClass('highlight');
			currPopoverID = null;
			currRow = null;
		}

	});
});



























