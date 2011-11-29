class BuyListing < Listing
    
    def type_name
        'Buy'
    end
    
    def other_type_name
        'Sell'
    end

    def comparator
        '<='
    end
    
end