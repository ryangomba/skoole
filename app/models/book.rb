class Book < ActiveRecord::Base
    
    has_many :listings
    
    validates_presence_of :isbn
    attr_accessible :isbn, :author, :title, :published, :thumbnail
end