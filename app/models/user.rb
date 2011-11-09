require 'rubygems'
require 'httparty'
require 'message'

class User < ActiveRecord::Base
    
    has_many :listings
    
    validates_presence_of :first_name, :last_name, :email, :image, :f_id, :f_token
    
    def self.create_with_facebook(fb)
        user = find_by_f_id(fb["uid"])
        user ? user : create(
            f_id: fb["uid"],
            f_token: fb["credentials"]["token"],
            first_name: fb["info"]["first_name"],
            last_name: fb["info"]["last_name"],
            email: fb["info"]["email"],
            image: fb["info"]["image"]
        )
    end
    
    ##
    
    def test
        Facebook.user('ryangomba', self.f_token)
    end
    
    ##### MESSAGING #####
    
    def new_number
        nums = self.nums.dup
        number_id = nums.index('0') + 1
        nums[number_id - 1] = '1'
        nums = "#{nums}".to_s
        self.save()
        return number_id
    end
   
end
