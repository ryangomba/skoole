$(document).ready(function() {
	
    $(document).delegate(".add", "click", function() {
        $(this).parent().find('.overlay').fadeIn()
    });

    $(document).delegate('.overlay form', 'submit', function() {
        $('.overlay').fadeOut('fast');
    });

	$(document).delegate(".destroy", "click", function() {
		$(this).parents('.listing').animate({ height: 'toggle', opacity: 'toggle' }, 300, function() {
			$(this).remove()
		})
	})

})