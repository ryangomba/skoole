$(document).ready(function() {
	
	$('.overlay').click(function() {
		$(this).fadeOut()
	})

	$('.edit_user input').click(function() {
		$('.edit_user').submit()
	})
	
	$('.nit').click(function() {
		$('div#account-wrapper').fadeToggle()
	})
	
})

function login() {
	$('#facebook').fadeIn()
}