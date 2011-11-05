require 'auth'

class User < ActiveRecord::Base
    
    validates_presence_of :name, :email, :sms, :uid
      
    def self.create_with_omniauth(auth)
      create! do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = auth["user_info"]["name"]
        user.sms = 'bla'
        user.email = 'bla'
      end
    end
    
end
