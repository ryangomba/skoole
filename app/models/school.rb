class School < ActiveRecord::Base
    
    validates_presence_of :name, :url, :domain
    
end