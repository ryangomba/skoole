require 'rubygems'
require 'httparty'

require 'message'

class Nexmo
    include HTTParty
    base_uri 'http://rest.nexmo.com'
    default_params :username => '86e3fbf7', :password => '414092e9'
    format :json
    def self.send(message)
        get('/sms/json', :query => {
            :from => message.sender.sms,
            :to => message.receiver.sms,
            :text => message.body
        })
    end
end

class Sendgrid
    include HTTParty
    base_uri 'https://sendgrid.com/api'
    default_params :api_user => 'ryangomba', :api_key => '8893300r'
    format :json
    def self.send(message)
        get('/mail.send.json', :query => {
            :from => message.sender.email,
            :fromname => message.sender.name,
            :to => message.receiver.email,
            :toname => message.receiver.name,
            :subject => message.subject,
            :text => message.body
        })
    end
end

class MessagesController < ApplicationController

    def in
        puts 'recieved'
        puts params.inspect
        
        respond_to do |format|
        end
    end
    
    def out
        sender = Contact.new('Skoole', '123@skoole.com', '12064532171')
        receiver = Contact.new('Ryan', 'ryan@ryangomba.com', '18457026112')        
        message = Message.new(sender, receiver, 'test')
        
        sms_response = Nexmo.send(message)
        puts sms_response.body, sms_response.code, sms_response.message, sms_response.headers.inspect
        
        email_response = Sendgrid.send(message)
        puts email_response.body, email_response.code, email_response.message, email_response.headers.inspect
        
        respond_to do |format|
        end
        
    end

end
