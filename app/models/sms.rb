require 'api/nexmo'

class Sms < Dispatch
    
    def send
        Nexmo.send(self)
    end
   
end
