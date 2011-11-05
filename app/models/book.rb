class Book < ActiveRecord::Base
    
    belongs_to :listing
    
    validates_presence_of :isbn
    attr_accessible :isbn
end