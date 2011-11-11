require 'rubygems'
require 'httparty'

class Nexmo
    
    include HTTParty
    base_uri 'http://rest.nexmo.com'
    default_params username: '86e3fbf7', password: '414092e9'
    format :json
    
    def self.send(message, to)
        puts "Sending sms from #{message.sms} to #{to.sms}."
        get('/sms/json', query: {
            from: message.sms,
            to: to.sms,
            text: message.short
        })
    end
    
end