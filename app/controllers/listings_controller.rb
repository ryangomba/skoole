class ListingsController < ApplicationController

    def index
        @listings = {
            'Buy' => current_user.listings.buy,
            'Sell' => current_user.listings.sell
        }
        @new_listing = Listing.new
    end

    def create
        @book = Book.via_isbn(params[:isbn])
        @listing = @book.listings.create(params[:listing]) if @book
        if @book.nil? || @listing.nil?
            puts "Error saving listing"
        else
            # @listing.match # check for matches
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
