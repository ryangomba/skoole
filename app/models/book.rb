require 'api/googlebooks'

class Book < ActiveRecord::Base
    
    has_many :listings
    has_many :buy_listings
    has_many :sell_listings
    
    validates_presence_of :isbn
    attr_accessible :isbn, :author, :title, :published, :thumbnail
    
    def self.via_isbn(isbn)
        book = self.find_by_isbn(isbn)
        if book.nil? then book = GoogleBooks.book_for_isbn(isbn) end
        return book
    end
    
end