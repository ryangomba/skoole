# A message

class Contents
    attr_reader :subject, :short, :full
    def initialize(subject, short, full)
        @subject = subject
        @short = short
        @full = full
    end
end

# Create the appropriate message for a transaction

def contents_for_transaction(t, msg)
    
    buyer = User.find(t.buyer_id)
    seller = User.find(t.seller_id)
    bl = Listing.find(t.buyer_listing_id)
    sl = Listing.find(t.seller_listing_id)
    bn = Listing.find(t.buyer_listing_id)
    sn = Listing.find(t.seller_listing_id)
    bk = bl.book.title

    case t.state
    when 0
        subject =   "We found a match!"
        short =     "Would you like to purchase #{bk} from #{seller.firstname} for $#{sl.price}?"
        full =      "Would you like to purchase #{bk} from #{seller.firstname} for $#{sl.price}?"
    when 1
        subject =   "We found a match!"
        full =      "Would you like to sell #{bk} to #{buyer.firstname} for $#{sl.price}?"
        full =      "Would you like to sell #{bk} to #{buyer.firstname} for $#{sl.price}?"
    when 2
        subject =   "Your match is set!"
        full =      "Alrighty. You're all set! Use this number to arrange when & where to meet (we won't be eavesdropping)."
        full =      "Alrighty. You're all set! Use this number to arrange when & where to meet (we won't be eavesdropping)."
    when 3
        subject =   "You have a message!"
        short =     msg
        full =      msg
    when 9
        subject =   "Match canceled."
        short =     "No problem. You're back in the queue! :)"
        full =      "No problem. You're back in the queue! :)"
    else
        return error_message()
    end
    
    return Contents.new(subject, short, full)

end

# Create an error message

def contents_error
        
    subject =   "Error!"
    short =     "We had an error processing your request. An administrator has been notified."
    full =      "We had an error processing your request. An administrator has been notified."
    return Contents.new(subject, short, full)
    
end