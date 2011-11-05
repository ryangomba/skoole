class ListingsController < ApplicationController
  
  include ApplicationHelper
  
  def new
    @listings = [Listing.new, Listing.new, Listing.new, Listing.new, Listing.new]
  end
  
  def update
    
  end
  
  def create
    @isbn = params[:listing][:book][:isbn]
    
    @newListing = Listing.new
    @newListing.update_attributes(:price=> params[:listing][:price], :condition => params[:listing][:condition], :kind => params[:listing][:kind])
    @old_book = Book.find_by_isbn(@isbn)
    
    if (@old_book)
      @newListing.book_id = @old_book.id
    else
      resultHash = isbn_request(@isbn)
      @new_book = Book.create(:isbn => @isbn, :title => resultHash["title"], :author => resultHash["author"], :thumbnail => resultHash["thumbnail"], :published => resultHash["published"])
      @new_book.save
      @newListing.book_id = @new_book.id
    end
    
    respond_to do |format|
      if @newListing.save
        format.html {redirect_to new_listing_path}
      else
        format.html {redirect_to '/'}
      end
    end
  end
  
end
