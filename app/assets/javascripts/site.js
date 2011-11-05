$(document).ready(function() {
	
    $('.overlay').click(function(event) {
        if ($(event.target).is('.overlay'))
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

function loggedin(response) {

    $(document).ready(function() {

        if(response != null) {
            $.post('/autologin', response)
            //logged user id: FB.getSession().uid
        } else {
            //alert('out')
            //user is not logged in
        }

    })

}

