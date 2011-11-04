class User < ActiveRecord::Base
    
    validates_presence_of :name, :email, :sms, :f_id
    
end
