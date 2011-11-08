// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs

$(document).ready(function() {
	
	// AUTH POPOP
	
	function popupCenter(url, width, height, name) {
		var left = (screen.width/2)-(width/2);
		var top = (screen.height/2)-(height/2);
		return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
	}
	$("a.popup").click(function(e) {
		popupCenter($(this).attr("href"), $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
		e.stopPropagation(); return false;
	});
	if(window.opener) {
		window.opener.didlogin()
	    window.close()
	}
	
	// hide an overlay when it is dismissed
    $('.overlay').click(function(event) {
        if ($(event.target).is('.overlay'))
            $(this).fadeOut()
    })

	// edit user button
	$('.edit_user input').click(function() {
		$('.edit_user').submit()
	})
	
	// show/hide account box
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
			//alert('user is logged into facebook')
            //$.post('/autologin', response)
            //logged user id: FB.getSession().uid
        } else {
			//alert('user is not logged into facebook')
            //alert('out')
            //user is not logged in
        }

    })

}

function didlogin() {
	alert()
}
