class Listing < ActiveRecord::Base
    
    has_one :transaction
    belongs_to :book
    belongs_to :user
    
    # user_id
    validates_presence_of :kind, :book, :user, :price, :condition
 
    def condition_name
        case self.condition
        when '0'
            "new"
        when '1'
            "good"
        when '2'
            "fair"
        end
    end
   
end
