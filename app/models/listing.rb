class Listing < ActiveRecord::Base
    
    belongs_to :transaction
    
    # user_id
    validates_presence_of :kind, :book_id, :price, :condition
    
end