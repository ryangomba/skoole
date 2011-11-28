require 'rubygems'
require 'httparty'
require 'message'

class User < ActiveRecord::Base
    
    has_many :listings
    has_many :buy_listings
    has_many :sell_listings
    
    validates_presence_of :first_name, :last_name, :image, :f_id, :f_token
    
    validate :edu_email
    def edu_email
        if self.email && !(self.email =~ /\.edu$/) then self.email = nil end
    end
    
    validate :us_phone
    def us_phone
        if self.sms
            self.sms = self.sms.gsub(/\D/, '')
            if self.sms.size == 10 then self.sms = '1' + self.sms end
            if self.sms.size != 11 then self.sms = nil end
        end
    end
    
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
    
    def ready
        self.email && self.sms
    end
   
end
