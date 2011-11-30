class TwilioController < ApplicationController
    
    def sms
        puts params.inspect
    end
    
    def voice
        puts params.inspect
        render :file => 'twilio/voice.xml', :content_type => Mime::XML
    end

end
