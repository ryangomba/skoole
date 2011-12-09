window.setInterval(poll, 2000);

function poll() {
    if (polling == true && $('#lists-container').length > 0) {
	$.ajax({
	    url: '/poll_listings',
		type: 'get',
		dataType: 'script'
	})
    }
}

$(document).ready(function() {
	
    $(document).delegate(".add", "click", function() {
        $(this).parent().find('.overlay').fadeIn()
    });

    $(document).delegate('.overlay form', 'submit', function() {
        $('.overlay').fadeOut('fast')
    });

	$(document).delegate(".overlay .exit", "click", function() {
        $('.overlay').fadeOut('fast')
    });

	$(document).delegate('form.new_listing_form input.isbn-text-field', 'focus', function() {
		if ($(this).val() == LISTING_PROMPT_TEXT) $(this).val('')
		$(this).removeClass('empty')
	});

	$(document).delegate('form.new_listing_form input.isbn-text-field', 'blur', function() {
		if ($(this).val() == '') {
			$(this).val(LISTING_PROMPT_TEXT)
			$(this).addClass('empty')
		}
	});

})

function clear_forms() {
	$('input.isbn-text-field').val(LISTING_PROMPT_TEXT)
}

function update_counts() {
	$('#BuyListing.section .count').html($('#BuyListing.section .listing').length)
	$('#SellListing.section .count').html($('#SellListing.section .listing').length)
}
