class Transaction < ActiveRecord::Base
    
    has_one :buyer, :class_name => User, :foreign_key => "buyer_id"
    has_one :seller, :class_name => User, :foreign_key => "seller_id"
    
    has_one :buyer_number, :class_name => Number, :foreign_key => "buyer_number_id"
    has_one :seller_number, :class_name => Number, :foreign_key => "seller_number_id"
    
    has_one :buyer_listing, :class_name => Listing, :foreign_key => "buyer_id"
    has_one :seller_listing, :class_name => Listing, :foreign_key => "seller_number_id"
    
    validates_presence_of :buyer_id, :seller_id, :buyer_number_id, :seller_number_id, :buyer_listing_id, :seller_listing_id, :state
    
end