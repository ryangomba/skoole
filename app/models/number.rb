class Number < ActiveRecord::Base
    
    validates_presence_of :number, :index
    validates_uniqueness_of :number
    
end