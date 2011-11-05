$(document).ready(function() {
	$('.add').click(function() {
		var kind = $(this).attr('name')
		$('#new-book span#listing_title_kind').html(kind)
		$('#new-book input#listing_kind').val(kind)
		$('#new-book').fadeIn()
	})
})