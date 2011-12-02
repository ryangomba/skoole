Rails.application.config.middleware.use OmniAuth::Builder do
    
	if Rails.env == 'development'
	    APP_ID = '321553274523479'
	    APP_SECRET = 'a679261cdb46fdeceeb5ed5001efb8c0'
	elsif Rails.env == 'staging'
	    APP_ID = '143680292405619'
	    APP_SECRET = '590175c926d6689e2b8dc6fd3269e386'
    else
        APP_ID = '184512731633300'
	    APP_SECRET = '434eb084d0cacaefd9bbec9dc1e0c5b4'
    end
	
	provider :facebook, APP_ID, APP_SECRET,
	    scope: 'email, offline_access, publish_actions, publish_stream', :authorize_params => { :display => 'popup' }

end