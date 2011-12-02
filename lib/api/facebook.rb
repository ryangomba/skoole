require 'httparty'

class Facebook
    
    if Rails.env == 'development'
	    APP_ID = '321553274523479'
	    APP_SECRET = 'a679261cdb46fdeceeb5ed5001efb8c0'
	    APP_NAMESPACE = 'skoole_local'
	elsif Rails.env == 'staging'
	    APP_ID = '143680292405619'
	    APP_SECRET = '590175c926d6689e2b8dc6fd3269e386'
	    APP_NAMESPACE = 'skooledev'
    else
        APP_ID = '184512731633300'
	    APP_SECRET = '434eb084d0cacaefd9bbec9dc1e0c5b4'
	    APP_NAMESPACE = 'skoole'
    end
    
    include HTTParty
    base_uri 'https://graph.facebook.com'
    default_params api_user: APP_ID, api_key: APP_SECRET
    format :json
    
    # an example...
    
    def self.user(username, token)
        puts "Getting facebook user info"
        puts get("/#{username}", query: {
            access_token: token
        }).inspect
    end
    
    def self.listed(listing)
        puts "Posting the listing to facebook"
        puts post("/#{listing.user.f_id}/#{APP_NAMESPACE}:#{listing.type_name.downcase}", query: {
            book: "#{SkooleSettings.host_url}/books/#{listing.book_id}",
            price: listing.price,
            access_token: listing.user.f_token
        }).inspect
    end
    
    def self.matched(user, match)
        puts "Posting the match to facebook"
        puts post("/#{user.f_id}/#{APP_NAMESPACE}:#{match.action(user)}", query: {
            book: "#{SkooleSettings.host_url}/books/#{match.book_id}",
            price: match.price,
            savings: match.savings,
            access_token: listing.user.f_token
        }).inspect
    end
    
end
