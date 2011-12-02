class ListingsController < ApplicationController

    def index
        session[:last_request] = Time.now
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

    def poll
        time = Time.now
        @polling = true
        @listing = Listing.last
        if @listing.created_at < session[:last_request] then @listing = nil end
        session[:last_request] = time
        render 'create'
    end

    def create        
        if @book = Book.via_isbn(params[:isbn])
            @listing = @book.buy_listings.create(params[:buy_listing]) if params[:buy_listing]
            @listing = @book.sell_listings.create(params[:sell_listing]) if params[:sell_listing]
        end
        session[:last_request] = Time.now
        if @book.nil?
            puts "No book found for this ISBN."
        end
        if @listing.nil?
            puts "No listing found for this book."
        else
            @listing.match
        end
    end
    
    def destroy
        @listing = Listing.find(params[:id])
        @listing.destroy
    end
  
end
