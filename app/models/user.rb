class User < ActiveRecord::Base
    
    has_many :listings
    has_many :buy_listings
    has_many :sell_listings
    has_many :messages
    
    validates_presence_of :first_name, :last_name, :image, :f_id, :f_token
    validates_uniqueness_of :sms, :allow_blank => true, :allow_nil => true
    validates_uniqueness_of :email, :allow_blank => true, :allow_nil => true
    
    validate :edu_email
    def edu_email
        if self.email && !(self.email =~ /\.edu$/)
            self.email = nil
        else
            parts = self.email.split(/[@.]/)
            if parts.size > 2 
                self.network = parts[parts.size-2]
            else
                self.email = nil
            end
        end
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
    
    def find_friend_match(listings)
        
        puts "Searching through friends for matches..."
        friend_array = Facebook.user_friends(self.f_id, self.f_token)
        listings.each do |listing|
            puts listing.user.f_id
            friend_array.each do |friend|
                if listing.user.f_id == friend["id"]
                    puts "Friend match found!!"
                    return listing
                end
            end
        end
        return nil
    end
    
    ##### HELPERS #####
    
    def full_name
        "#{self.first_name} #{self.last_name}"
    end
    
    def school
        School.find_by_domain(self.network)
    end
    
    ##### MESSAGING #####
    
    def new_number
        nums = self.nums.dup
        number_id = nums.index('0') + 1
        nums[number_id - 1] = '1'
        nums = "#{nums}".to_s
        self.save()
        return Number.find_by_index(number_id)
    end
    
    def ready
        self.email && self.sms && self.network
    end
    
    def member
        self.ready && self.network == 'gatech'
    end
   
end
