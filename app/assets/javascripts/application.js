// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
	
	window.location.hash = ''
	
	$(document).delegate("a.nav-item div, .header h1", "click", function() {
		$('a.nav-item div.selected').removeClass('selected')
		$(this).addClass('selected')
	})
	
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

	// user on FB?
	getLoginStatus()

})

// determine if a user us logged into Facebook
function getLoginStatus() {
	var f_id = null
	window.fbAsyncInit = function() {
		FB.init({appId: '184512731633300', status: true, cookie: true, xfbml: true});
		FB.getLoginStatus(loggedin);
		FB.Event.subscribe('auth.statusChange', loggedin);
	};
	(function() {
		var e = document.createElement('script'); e.async = true;
		e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
		document.getElementById('fb-root').appendChild(e);
	}());
	function loggedin(response) {
		if (response['session'] != null) {
			f_id = response['session']['uid']
			$("#connect-with-facebook").attr('href', '/login?f_id=' + f_id)
		}
	}
}

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
