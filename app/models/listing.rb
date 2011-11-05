class Listing < ActiveRecord::Base
    
    belongs_to :transaction
    
    has_one :user
    has_one :book
    
    validates_presence_of :kind, :book, :price, :condition
    accepts_nested_attributes_for :book
    
end