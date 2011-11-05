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
    
    def initialize(sk, r, t)

        @sender = sk
        @receiver = r
        @t = t

        buyer = User.find(t.buyer_id)
        seller = User.find(t.seller_id)
        bl = Listing.find(t.buyer_listing_id)
        sl = Listing.find(t.seller_listing_id)
        bk = bl.book.title
        
        case @t.state
        when 0
            @subject =  "We found a match!"
            @body =     "Would you like to purchase #{bk} from #{seller.firstname} for $#{sl.price}?"
        when 1
            @subject =  "We found a match!"
            @body =     "Would you like to sell #{bk} to #{buyer.firstname} for $#{sl.price}?"
        when 2
            @subject =  "Your match is set!"
            @body =     "Alrighty. You're all set! Use this number to arrange when & where to meet (we won't be eavesdropping)."
        when 3
            @subject =  "You have a message!"
            @body =     "boo"
        when 9
            @subject =  "Match canceled."
            @body =     "No problem. You're back in the queue! :)"
        else
            @subject =  "Error"
            @body =     "Error"
        end
        
    end
    
end
