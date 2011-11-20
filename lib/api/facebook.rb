require 'rubygems'
require 'httparty'

class Facebook
    
    include HTTParty
    base_uri 'https://graph.facebook.com'
    default_params api_user: '184512731633300', api_key: '434eb084d0cacaefd9bbec9dc1e0c5b4'
    format :json
    
    # an example...
    
    def self.user(username, token)
        puts get("/#{username}", query: {
            access_token: token
        }).inspect
    end
    
end