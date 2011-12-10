// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree ./vars
//= require_tree ./views

$(document).ready(function() {
	
	window.location.hash = ''
	
	$(document).delegate("a.nav-item, .header h1", "click", function() {
		$('a.nav-item.selected').removeClass('selected')
		$(this).addClass('selected')
	})
	
	// hide an overlay when it is dismissed
    $(document).delegate(".overlay", "click", function(event) {
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
		FB.init({appId: FB_APP_KEY, status: true, cookie: true, xfbml: true});
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
			$("#connect-with-facebook").attr('href', '/connect?f_id=' + f_id)
		}
	}
}

// refresh the page after login
function authorized() {
	$.ajax({
	    url: '/authorized',
		type: 'get',
		dataType: 'script'
	})
}

function updateTabs(tabs) {
	$('#tabs').fadeOut(100, function() {
		$(this).html(tabs).fadeIn(500, function() {
			getLoginStatus()
		})
	})
}
