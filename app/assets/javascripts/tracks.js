// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
	$('#play-button').click(function() {
		console.log("Play");
		soundManager.play('mySound');
		$(this).toggle();
		$("#stop-button").toggle();
		// 'mySound' makes it point to your soundManager code, inside the <script> tags in the show page.
	});
	$('#stop-button').click(function() {
		console.log("stop");
		$(this).toggle();
		soundManager.stop('mySound');
	});
});