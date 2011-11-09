// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs

$(document).ready(function() {
	
	// hide the facebook window when complete
	if(window.opener) {
		window.opener.didlogin()
	    window.close()
	}
	
	// hide an overlay when it is dismissed
    $('.overlay').click(function(event) {
        if ($(event.target).is('.overlay'))
            $(this).fadeOut()
    })

})

// pop the facebook dialog
function popupCenter() {
	var width = 640
	var height = 400
	var left = (screen.width/2)-(width/2);
	var top = (screen.height/2)-(height/2);
	return window.open("/auth/facebook", "authPopup", "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",left="+left+",top="+top);
}

// refresh the page after login
function didlogin() {
	$.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script
	$.ajax({
	    url: '/login',
		type: 'get',
		dataType: 'script'
	})
}
