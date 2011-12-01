require 'rubygems'
require 'httparty'

require 'contents'

class MessagesController < ApplicationController

    def nexmo_sms                        
        from = params[:msisdn]
        to = params[:to]
        msg = params[:text]

        # a test number (just forward it on to ryan)
        if to == '12064532948'
            sms = Sms.new(
                message_id: 0,
                from_address: '12064532948',
                to_address: '18457026112',
                content: "FW FROM #{from}: #{msg}"
            )
            puts 'Sending to dummy number'
            sms.broadcast_now
            render nothing: true and return
        end
        
        Message.process_incoming(from, to, msg)       
        render nothing: true
    end
    
    def sendgrid_email
    end
    
    def twilio_sms
        from = params[:From].gsub(/\D/, '')
        to = params[:To].gsub(/\D/, '')
        msg = params[:Body]
        
        Message.process_incoming(from, to, msg)       
        render nothing: true
    end
    
    def twilio_voice
        puts params.inspect
        render :file => 'twilio/voice.xml', :content_type => Mime::XML
    end
    
    def process_message
    end

end
