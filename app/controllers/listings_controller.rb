class ListingsController < ApplicationController
    
    def isbn_request(isbn_args)
        response = JSON.parse(ISBNRequest.getISBN(isbn_args).body)

        @title = response["items"][0]["volumeInfo"]["title"]
        @author = response["items"][0]["volumeInfo"]["authors"][0]
        @thumbnail = response["items"][0]["volumeInfo"]["imageLinks"]["smallThumbnail"]
        @published = response["items"][0]["volumeInfo"]["publishedDate"]

        return {"title" => @title, "author" => @author, "thumbnail" => @thumbnail, "published" => @published}
    end

    class ISBNRequest
        include HTTParty
        def self.getISBN(isbn_args)
            get('https://www.googleapis.com/books/v1/volumes', :query => {
                :q => "isbn:#{isbn_args}"
            })
        end
    end
    
    ### ACTIONS
  
    def new
        @listings = []
        5.times do
            @listings.push(Listing.new)
        end
    end
  
    def update
    end

    def create
        @isbn = params[:listing][:book][:isbn]

        @newListing = Listing.new
        @newListing.update_attributes(:price=> params[:listing][:price], :condition => params[:listing][:condition], :kind => params[:listing][:kind])

        @book = Book.find_by_isbn(@isbn)
        if (!@book)
            resultHash = isbn_request(@isbn)
            @book = Book.create(:isbn => @isbn, :title => resultHash["title"], :author => resultHash["author"], :thumbnail => resultHash["thumbnail"], :published => resultHash["published"])
            @book.save
        end
        @newListing.book_id = @book.id

        respond_to do |format|
            if @newListing.save
                format.html { redirect_to new_listing_path }
            else
                puts "HERE", @newListing.errors.inspect
                format.html {redirect_to '/'}
            end
        end
    end
  
end
