class Message < ActiveRecord::Base
    
    belongs_to :match
    belongs_to :user
    
    has_many :dispatches
    has_many :emails
    has_many :smses
    
    validates_presence_of :match_id, :user_id, :subject, :short, :full
    
    def dispatch
        if self.user.sms_enabled then self.queue_sms end
        #if self.user.email_enabled then self.queue_email end
    end
    
    def queue_sms
        puts 'Dispatching an SMS message'
        d = self.smses.create(
            from_address: self.match.number_for_user_id(self.user_id).number,
            to_address: self.user.sms,
            content: self.short
        )
        d.broadcast
    end
    
    def queue_email
        puts 'Dispatching an email message'
        d = self.emails.create(
            from_name: 'Skoole.com',
            from_address: "match-#{self.match_id}@skoole.com}",
            to_name: self.user.full_name,
            to_address: self.user.email,
            subject: self.subject,
            content: self.full
        )
        d.broadcast
    end
    
end
