class Dispatch < ActiveRecord::Base
    
    belongs_to :message
    
    validates_presence_of :type, :message_id, :from_address, :to_address
    
    def broadcast
        SkooleSettings.queuing ? (Delayed::Job.enqueue self) : self.perform
    end
    
    def perform
        'Broadcasting the message now'
        self.broadcast_now
    end
   
end
