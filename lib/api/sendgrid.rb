require 'rubygems'
require 'httparty'

class Sendgrid
    
    include HTTParty
    base_uri 'https://sendgrid.com/api'
    default_params api_user: 'ryangomba', api_key: '8893300r'
    format :json
    
    def self.send(dispatch)
        puts "Sending email from #{dispatch.from_address} to #{dispatch.to_address}."
        request = get('/mail.send.json', query: {
            from: dispatch.from_address,
            fromname: dispatch.from_name,
            to: dispatch.to_address,
            toname: dispatch.to_name,
            subject: dispatch.subject,
            text: dispatch.content
        })
        puts request
        return request.response.class == Net::HTTPOK
    end
    
end