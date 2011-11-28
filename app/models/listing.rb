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
            New: 0,
            Good: 1,
            Fair: 2
        }
    end
 
    def condition_name
        return Listing.conditions.key(self.condition)
    end
    
    def fetch_matches
        return Listing.where("book_id = ? AND pending = ? AND network = ? AND user_id != ?
            AND type = ? AND price #{self.comparator} ? AND condition #{self.comparator} ?",
            self.book_id, false, self.network, self.user_id,
            "#{self.type_name}Listing", self.price, self.condition
        ).oldest
    end
    
    ##### CHECK FOR MATCHES
    
    def match
        
        if self.type == 'BuyListing'
            buyer = self.user
            buyer_listing = self
            seller_listing = self.fetch_matches.first
        else
            seller = self.user
            seller_listing = self
            buyer_listing = self.fetch_matches.first
        end
        
        # unless we found a match, just quit
        unless buyer_listing && seller_listing
            puts "NO MATCH FOUND"
            return
        end
            
        #get the other user
        buyer.nil? ? buyer = buyer_listing.user : seller = seller_listing.user

        # create the match
        t = Match.create(
            buyer_id: buyer.id,
            buyer_number_id: buyer.new_number(),
            buyer_listing_id: buyer_listing.id,
            seller_id: seller.id,
            seller_number_id: seller.new_number(),
            seller_listing_id: seller_listing.id,
            network: self.network,
            state: 0
        )

        # try to save the match
        if !t.save() 
            puts "Error creating match: #{t.errors.inspect}"
            return
        end
            
        # mark listings as pending
        buyer_listing.pending = true
        seller_listing.pending = true
        
        if buyer_listing.save && seller_listing.save
            
            # send the first message
            #msg = make_message(t, msg)
            #sms_response = buyer.send_sms(Number.find(buyer_number), msg)
            #email_response = buyer.send_email("#{@t.id}@skoole.com", msg)
            #puts "SMS RESPONSE:", sms_response.body, sms_response.code, sms_response.message, sms_response.headers.inspect
            #puts "EMAIL RESPONSE:", email_response.body, email_response.code, email_response.message, email_response.headers.inspect
            puts 'SHOULD SEND THE FIRST MESSAGE!'
            
        else
            puts "Error marking listings as pending: #{buyer_listing.errors.inspect}, #{seller_listing.errors.inspect}"
        end
        
    end
   
end
