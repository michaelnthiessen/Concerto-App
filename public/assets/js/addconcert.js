$(document).ready(function() {

	// Define the number of artists
	artistsNum = 1;

	// Bind to the first add button
	$('a.add-artist').click(function() {

		// Create a new artist
		createNewArtist( $(this) );

	});

	// Bind to the first delete button
	$('a.delete-artist').click(function() {

		// Create a new artist
		deleteArtist( $(this) );

	});

    $.validator.addMethod('alert', function(value){
        alert('WHAT>?>');
    }, 'seriously, guy');

    // Add validation
    $('.concert').validate({
        rules: {
            alert: true
        }
    });


});



// Method to create new artists
function createNewArtist(thisObj) {

	content = "<div class='control-group'><div class='controls'><input id='newArtist' class='span3' type='text' placeholder='Michael Jackson' name='artist1'>&nbsp; <a class='btn btn-success add-artist'><i class='icon-plus icon-white'></i></a>&nbsp;<a class='btn btn-danger delete-artist'> <i class='icon-minus icon-white'></i></a></div></div>";

	// Add the div
    thisObj.parent().parent().after(content);
    artistsNum++;

    // Change the name to prevent conflicts;
    $('#newArtist').attr( {
    	id: 'artist' + artistsNum,
    	placeholder: 'Artist'
	});

	// Bind the click events
	$('#artist' + artistsNum).next().click(function() {
		createNewArtist($(this));
	}).next().click(function() {
		deleteArtist($(this));
	});

};

// Method to delete artists
function deleteArtist(thisObj) {
	thisObj.parent().parent().remove();
};