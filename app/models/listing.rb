class Listing < ActiveRecord::Base
    scope :buy, where(kind: 'Buy')
    scope :sell, where(kind: 'Sell')
    
    has_one :match
    belongs_to :book
    belongs_to :user
    
    # user_id
    validates_presence_of :kind, :book, :user, :price, :condition
    accepts_nested_attributes_for :book
 
    def condition_name
        case self.condition
        when '0'
            "new"
        when '1'
            "good"
        when '2'
            "fair"
        end
    end
    
    ##### CHECK FOR MATCHES
    
    def fetch_match
        return Listing.where("book_id = ? AND pending = ? AND kind = 'Sell' AND price <= ? AND condition <= ? AND id < ?",
            self.book_id, false, self.price, self.condition, self.id
        ).order('created_at ASC').first
    end
    
    def match
        
        if self.kind == 'Buy'
            buyer = self.user
            buyer_listing = self
            seller_listing = self.fetch_match()
        else
            seller = self.user
            seller_listing = self
            buyer_listing = self.fetch_match()
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
