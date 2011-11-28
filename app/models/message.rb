class Message < ActiveRecord::Base
    
    belongs_to :match
    belongs_to :user
    
    has_many :dispatches
    
    validates_presence_of :match_id, :user_id, :subject, :short, :full
    
    def dispatch
        if self.user.sms_enabled then self.queue_sms end
        if self.user.email_enabled then self.queue_email end
    end
    
    def queue_sms
        d = self.dispatches.create(
            from_address: self.match.number_for_user_id(self.user_id),
            to_address: self.user.sms,
            content: self.short
        )
        d.delayed_send
    end
    
    def queue_email
        d = self.dispatches.create(
            from_name: 'Skoole.com',
            from_address: "match-#{self.match_id}@skoole.com}",
            to_name: self.user.name,
            to_address: self.user.email,
            subject: self.subject,
            content: self.full
        )
        d.delayed_send
    end
    
end