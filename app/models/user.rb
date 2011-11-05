require 'auth'

class User < ActiveRecord::Base
    
    validates_presence_of :name, :email, :sms, :uid
      
    def self.create_with_omniauth(auth, params)
      create! do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = params["name"]
        user.sms = params["phone"]
        user.email = params["email"]
      end
    end
    
end
