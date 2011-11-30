class TwilioController < ApplicationController
    
    def sms
        puts params.inspect
    end
    
    def voice
        puts params.inspect
        respond_to do |format|
            format.xml
        end
    end

end
