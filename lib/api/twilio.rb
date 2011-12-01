require 'httparty'

class Twilio
    
    ACCOUNT_SID = 'ACb68ee40587b24487b2b6a858003892b2'
    AUTH_TOKEN = 'dd3c2c8bb00f15f3813b495d7976e98a'
    
    include HTTParty
    base_uri "https://api.twilio.com/2010-04-01/Accounts/#{ACCOUNT_SID}"
    basic_auth ACCOUNT_SID, AUTH_TOKEN
    format :xml
    
    def self.send_sms(dispatch)
        puts "Sending sms from #{dispatch.from_address} to #{dispatch.to_address} via Twilio."
        request = post('/SMS/Messages', {
            body: {
                :From => "+#{dispatch.from_address}",
                :To => "+#{dispatch.to_address}",
                :Body => dispatch.content
            }})
        puts request.request.last_uri
        puts request
        return request.response.class == Net::HTTPOK
    end
    
    def self.call(dispatch)
        puts "Calling #{dispatch.to_address} from #{dispatch.from_address} via Twilio."
        request = post('/Calls', {
            body: {
                :From => "+#{dispatch.from_address}",
                :To => "+#{dispatch.to_address}",
                :Url => "#{SkooleSettings.host_url}/twilio/voice"
            }})
        puts request.request.last_uri
        puts request
        return request.response.class == Net::HTTPOK
    end
    
end