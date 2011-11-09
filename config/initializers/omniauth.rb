Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '184512731633300', '434eb084d0cacaefd9bbec9dc1e0c5b4', scope: 'email, offline_access'
end