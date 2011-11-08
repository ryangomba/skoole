require 'rubygems'
require 'httparty'

class Sendgrid
    
    include HTTParty
    base_uri 'https://sendgrid.com/api'
    default_params :api_user => 'ryangomba', :api_key => '8893300r'
    format :json
    
    def self.send(message)
        puts "Sending email from #{messsage.email} to #{to.email}."
        get('/mail.send.json', :query => {
            :from => message.from_email,
            :fromname => 'Skoole',
            :to => message.to_email,
            :toname => to.name,
            :subject => message.subject,
            :text => message.full
        })
    end
    
end