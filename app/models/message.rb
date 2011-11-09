class Message < ActiveRecord::Base
    
    validates_presence_of :sender_id, :receiver_id
    
    def email
        self.t_id ? "#{self.t_id}@skoole.com}" : 'desk@skoole.com'        
    end
    
    def set_contents(contents)
        self.subject = contents.subject
        self.short = contents.short
        self.long = contents.long
    end
    
    ##### MESSAGING
    
    def send(user)
        self.user_id = user_id
        self.send_sms
        self.send_email
    end
    
    def send_email(user)
        if user.sms_enabled == true
            response = HTTParty.get('http://rest.nexmo.com/sms/json',
            format: json,
            query: {
                username: '86e3fbf7',
                password: '414092e9',
                from: self.sms,
                to: user.sms,
                text: self.short
            })
            puts response.inspect
        end
    end
    
    def send_sms(user)
        if user.email_enabled == true
            response = Sendgrid.send(message, user)
            puts response.inspect
        end
    end
    
    
    
end