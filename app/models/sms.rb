require 'api/nexmo'
require 'api/twilio'

class Sms < Dispatch
    
    validates_presence_of :content
    
    def broadcast_now
        SkooleSettings.sms_service.constantize.send_sms(self)
        sleep(1) # let the circuits clear
    end
   
end
