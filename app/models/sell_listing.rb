class SellListing < Listing
    
    def type_name
        'Sell'
    end
    
    ##### FIND MATCHES
    def fetch_matches
        return Listing.where("book_id = ? AND pending = ? AND type = 'BuyListing' AND price >= ? AND condition >= ? AND user_id != ?",
            self.book_id, false, self.price, self.condition, self.user_id
        ).oldest
    end
    
end