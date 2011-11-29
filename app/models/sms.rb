require 'api/nexmo'

class Sms < Dispatch
    
    def broadcast_now
        sleep(1) # let the circuits clear
        Nexmo.send(self)
    end
   
end
