class Dispatch < ActiveRecord::Base
    
    belongs_to :message
    
    validates_presence_of :type, :message_id, :from_address, :to_address, :content
    
    def delayed_send
        Delayed::Job.enqueue self
    end
    
    def perform
        self.send 
    end
   
end
