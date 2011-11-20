class Listing < ActiveRecord::Base
    scope :oldest, order('created_at ASC')
    
    has_one :match
    belongs_to :book
    belongs_to :user
    
    validates_presence_of :type, :book, :user, :price, :condition
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
    
    ##### CHECK FOR MATCHES
    
    def match
        return # for now
        
        if self.type == 'BuyListing'
            buyer = self.user
            buyer_listing = self
            seller_listing = self.fetch_matches.first
        else
            seller = self.user
            seller_listing = self
            buyer_listing = self.fetch_matches.first
        end
        
        # if we found a match
        if buyer_listing && seller_listing
            
            # get the other user
            buyer.nil? ? buyer = buyer_listing.user : seller = seller_listing.user

            # create the match
            t = Match.create(
                buyer_id: buyer.id,
                buyer_number_id: buyer.new_number(),
                buyer_listing_id: buyer_listing.id,
                seller_id: seller.id,
                seller_number_id: seller.new_number(),
                seller_listing_id: seller_listing.id,
                state: 0
            )
            t.save()
            
            if t.errors
                puts "Error creating match: #{t.errors}"
            else
                
                # mark listings as pending
                buyer_listing.pending = true
                seller_listing.pending = true
                buyer_listing.save
                seller_listing.save
                
                if buyer_listing.errors || seller_listing.errors
                    puts "Error marking listings as pending"
                else
                    
                    # send the first message
                    msg = make_message(t, msg)
                    sms_response = buyer.send_sms(Number.find(buyer_number), msg)
                    email_response = buyer.send_email("#{@t.id}@skoole.com", msg)
                    puts "SMS RESPONSE:", sms_response.body, sms_response.code, sms_response.message, sms_response.headers.inspect
                    puts "EMAIL RESPONSE:", email_response.body, email_response.code, email_response.message, email_response.headers.inspect
                    
                end
                
            end
           
        end
        
    end # match()
   
end
