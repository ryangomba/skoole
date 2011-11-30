require 'api/nexmo'
require 'api/twilio'

class Sms < Dispatch
    
    validates_presence_of :content
    
    def broadcast_now
        sleep(1) # let the circuits clear
        self.service.constantize.send_sms(self)
    end
   
end
