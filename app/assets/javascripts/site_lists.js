$(document).ready(function() {
	$('.add').click(function() {
		if ($('#list'+$(this).attr('name')+' .entry').length < 5) {
			var kind = $(this).attr('name')
			$('#new-book span#listing_title_kind').html(kind)
			$('#new-book input#listing_kind').val(kind)
			$('#new-book').fadeIn()
		}
	})
})