require 'api/nexmo'

class Sms < Dispatch
    
    def broadcast_now
        sleep(1)
        Nexmo.send(self)
    end
   
end
