class Contact
    
    attr_reader :name, :email, :sms
    
    def initialize(name, email, sms)
        @name = name
        @email = email
        @sms = sms
    end
    
end

class Message
    
    attr_reader :sender, :receiver, :t, :subject, :body
    
    def initialize(sender, receiver, transaction)
        @sender = sender
        @receiver = receiver
        @t = transaction
        
        # shortcuts
        bn = @sender.name
        sn = @receiver.name
        bl = Listing.find(@t.buyer_listing_id)
        sl = Listing.find(@t.seller_listing_id)
        bk = bl.book.title
        
        case @t.state
        when 0
            @subject =  "We found a match!"
            @body =     "Would you like to purchase #{bk} from #{sn} for $#{sl.price}?"
        when 1
            @subject =  "We found a match!"
            @body =     "Would you like to sell #{bk} to #{bn} for $#{sl.price}?"
        else
            @subject =  "Error"
            @body =     "Error"
        end
        
    end
    
end