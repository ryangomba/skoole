require 'api/sendgrid'

class Email < Dispatch
    
    validates_presence_of :from_name, :to_name, :subject
    
    def broadcast_now
        Sendgrid.send(self)
    end
   
end
