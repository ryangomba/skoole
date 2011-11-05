class Listing < ActiveRecord::Base
    
    has_one :transaction
    belongs_to :book
    belongs_to :user
    
    # user_id
    validates_presence_of :kind, :book, :user, :price, :condition
    
end