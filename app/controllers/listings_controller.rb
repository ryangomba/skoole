class ListingsController < ApplicationController

    def index
        @listings = {
            Buy: {
                list: current_user.buy_listings,
                new_listing: BuyListing.new
            },
            Sell: {
                list: current_user.sell_listings,
                new_listing: SellListing.new
            }
        }
    end

    def create        
        if @book = Book.via_isbn(params[:isbn])
            @listing = @book.buy_listings.create(params[:buy_listing]) if params[:buy_listing]
            @listing = @book.sell_listings.create(params[:sell_listing]) if params[:sell_listing]
        end
        if @book.nil? || @listing.nil?
            puts "Error saving listing"
        else
            @listing.match
            puts @listing.errors.inspect
            respond_to do |format|          
                format.js
            end
        end
    end
    
    def destroy
        @listing = Listing.find(params[:id])
        @listing.destroy
        respond_to do |format|
            format.js
        end
    end
  
end
