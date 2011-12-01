require 'api/twilio'

class Voice < Dispatch
    
    def broadcast_now
        self.service.constantize.call(self)
    end
   
end
