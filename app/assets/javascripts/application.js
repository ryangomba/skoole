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
	
	function popupCenter() {
		var width = 640
		var height = 400
		var left = (screen.width/2)-(width/2);
		var top = (screen.height/2)-(height/2);
		return window.open("/auth/facebook", "authPopup", "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",left="+left+",top="+top);
	}
	$("a.popup").click(function(e) {
		if (f_id) quick_login()
		else popupCenter();
		e.stopPropagation();
		return false;
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

function quick_login() {
	window.location = '/login?f_id=' + f_id
}

function didlogin() {
	window.location.reload()
	//alert()
}
