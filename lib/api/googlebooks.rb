require 'rubygems'
require 'httparty'

class GoogleBooks
    
    include HTTParty
    base_uri 'https://www.googleapis.com'
    default_params :username => '86e3fbf7', :password => '414092e9'
    format :json
    
    def self.book_for_isbn(isbn)
        puts "Getting book information for ISBN."
        book = get('/books/v1/volumes', :query => {
            :q => "isbn:#{isbn}"
        })["items"][0]["volumeInfo"]
        Book.create(
            :isbn => isbn,
            :title => book["title"],
            :author => book["authors"][0],
            :thumbnail => book["imageLinks"]["smallThumbnail"],
            :published => book["publishedDate"]
        )
    end
    
end