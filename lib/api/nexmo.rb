require 'rubygems'
require 'httparty'

class Nexmo
    
    include HTTParty
    base_uri 'http://rest.nexmo.com'
    default_params username: '86e3fbf7', password: '414092e9'
    format :json
    
    def self.send(dispatch)
        puts "Sending sms from #{dispatch.from_address} to #{dispatch.to_address}."
        request = get('/sms/json', query: {
            from: dispatch.from_address,
            to: dispatch.to_address,
            text: dispatch.content
        })
        puts request
        return request.response.class == Net::HTTPOK
    end
    
end