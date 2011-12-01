require 'api/sendgrid'

class Email < Dispatch
    
    validates_presence_of :from_name, :to_name, :subject, :content
    
    def broadcast_now
        SkooleSettings.email_service.constantize.send_email(self)
    end
   
end
