require 'api/facebook'

class Listing < ActiveRecord::Base
    scope :oldest, order('created_at ASC')
    
    has_one :match
    belongs_to :book
    belongs_to :user
    
    validates_presence_of :type, :book_id, :user_id, :price, :condition
    accepts_nested_attributes_for :book
    
    ##### CHILD CLASS NAMES
    
    @child_classes = []
    def self.inherited(child)
      @child_classes << child
      super # important!
    end
    def self.child_classes
      @child_classes
    end
 
    ##### CONDITIONS
 
    def self.conditions
        return {
            'New' => 0,
            'Good' => 1,
            'Fair' => 2
        }
    end
    
    def self.form_conditions
        return {
            'new condition' => 0,
            'good condition' => 1,
            'fair condition' => 2
        }
    end
 
    def condition_name
        return Listing.conditions.key(self.condition)
    end
    
    def fetch_matches

        @acceptable_listings = Listing.where("book_id = ? AND pending = ? AND network = ? AND user_id != ?
            AND type = ? AND price #{self.comparator} ? AND condition #{self.comparator} ?",
            self.book_id, false, self.network, self.user_id,
            "#{self.other_type_name}Listing", self.price, self.condition
        ).oldest
        
        @match = self.user.find_friend_match(@acceptable_listings)
        if @match.nil?
            is_friend = false
            puts "No friend match"
            return @acceptable_listings.first, is_friend
        else
            is_friend = true
            puts "Friend match found"
            puts @match
            return @match, is_friend
        end
         
    end
    
    ##### CHECK FOR MATCHES
    
    def match
        SkooleSettings.queuing ? (Delayed::Job.enqueue self) : self.perform
    end
    
    def perform
        puts "Looking for a match now..."
        self.post_now
        self.match_now
    end
    
    def post_now
        Facebook.listed(self)
    end
    
    def match_now        
        if self.type == 'BuyListing'
            buyer = self.user
            buyer_listing = self
            match_result = self.fetch_matches
            seller_listing = match_result[0]
            is_friend = match_result[1]
        else
            seller = self.user
            seller_listing = self
            match_result = self.fetch_matches
            buyer_listing = match_result[0]
            is_friend = match_result[1]
        end
        
        # unless we found a match, just quit
        unless buyer_listing && seller_listing
            puts "NO MATCH FOUND"
            return
        end
        
        #get the other user
        buyer.nil? ? buyer = buyer_listing.user : seller = seller_listing.user

        # create the match
        m = Match.create(
            buyer_id: buyer.id,
            buyer_number_id: buyer.new_number().id,
            buyer_listing_id: buyer_listing.id,
            seller_id: seller.id,
            seller_number_id: seller.new_number().id,
            seller_listing_id: seller_listing.id,
            network: self.network,
            friendly: is_friend,
            state: 0
        )
        
        if m.friendly
            puts "Friendly match! Awww..."
        end

        # try to save the match
        if !m.save() 
            puts "Error creating match: #{m.errors.inspect}"
            return
        end
            
        # mark listings as pending
        buyer_listing.pending = true
        seller_listing.pending = true
        
        if buyer_listing.save && seller_listing.save
            puts 'MATCH FOUND!'
            m.first_message
            Facebook.matched(buyer, m)
            Facebook.matched(seller, m)
        else
            puts "Error marking listings as pending: #{buyer_listing.errors.inspect}, #{seller_listing.errors.inspect}"
        end
        
    end
   
end
