class Book < ActiveRecord::Base
    
    belongs_to :listing
    
    validates_presence_of :isbn, :title, :author, :thumbnail, :published
    
end