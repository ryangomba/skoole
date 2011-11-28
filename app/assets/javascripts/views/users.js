var email_text = '.edu email address'
var sms_text = 'mobile phone number'

function init_signup_fields() {
	if ($('input#user_email').val() == '') $('input#user_email').val(email_text).addClass('empty')
	if ($('input#user_sms').val() == '') $('input#user_sms').val(sms_text).addClass('empty')
}

$(document).delegate('form.edit_user input', 'focus', function() {
	if ($(this).val() == email_text || $(this).val() == sms_text ) {
		$(this).val('')
	}
	$(this).removeClass('empty')
});

$(document).delegate('form.edit_user input', 'blur', function() {
	if ($(this).val() == '') {
		var text = '.edu email address'
	    if ($(this).attr('id') == 'user_sms') text = sms_text
		else text = email_text
		$(this).addClass('empty')
		$(this).val(text)
	}
});