class Number < ActiveRecord::Base
    
    validates_presence_of :number, :index
    
end