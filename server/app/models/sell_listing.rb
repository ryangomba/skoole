class SellListing < Listing
    
    def type_name
        'Sell'
    end
    
    def other_type_name
        'Buy'
    end
    
    def comparator
        '>='
    end
    
end