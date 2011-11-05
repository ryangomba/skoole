require 'rubygems'
require 'httparty'

require 'message'
require 'isbn'

class Nexmo
    include HTTParty
    base_uri 'http://rest.nexmo.com'
    default_params :username => '86e3fbf7', :password => '414092e9'
    format :json
    def self.send(message)
        get('/sms/json', :query => {
            :from => message.sender.sms,
            :to => message.receiver.sms,
            :text => message.body
        })
    end
end

class Sendgrid
    include HTTParty
    base_uri 'https://sendgrid.com/api'
    default_params :api_user => 'ryangomba', :api_key => '8893300r'
    format :json
    def self.send(message)
        get('/mail.send.json', :query => {
            :from => message.sender.email,
            :fromname => message.sender.name,
            :to => message.receiver.email,
            :toname => message.receiver.name,
            :subject => message.subject,
            :text => message.body
        })
    end
end

class ListingsController < ApplicationController

    def create
        
        fail = false
        
        # create book?

        @isbn = params[:listing][:book][:isbn]
        @book = Book.find_by_isbn(@isbn)
        if (!@book)
            resultHash = isbn_request(@isbn)
            @book = Book.create(:isbn => @isbn, :title => resultHash["title"], :author => resultHash["author"], :thumbnail => resultHash["thumbnail"], :published => resultHash["publishedDate"])
            fail = !@book.save
        end
        
        # create listing & link listing to book
        
        if !fail
            @listing = Listing.new
            @listing.update_attributes(:price=> params[:listing][:price], :condition => params[:listing][:condition], :kind => params[:listing][:kind])

            @listing.book_id = @book.id
            @listing.user_id = current_user.id
            fail = !@listing.save
        end
        
        # check for matches
        
        if !fail
            
            if @listing.kind == 'Buy'
                @buyer = current_user
                @buyer_listing = @listing
                @seller_listing = Listing.where("book_id = ? AND pending = ? AND kind = 'Sell' AND price <= ? AND condition <= ? AND id < ?",
                    @listing.book_id, false, @listing.price, @listing.condition, @listing.id
                ).order('created_at ASC').first
            else
                @seller = current_user
                @seller_listing = @listing
                @buyer_listing = Listing.where("book_id = ? AND pending = ? AND kind = 'Buy' AND price >= ? AND condition >= ? AND id < ?",
                    @listing.book_id, false, @listing.price, @listing.condition, @listing.id
                ).order('created_at ASC').first
            end
            
            if @buyer_listing && @seller_listing
                
                # get the other user
                if !@buyer
                    @buyer = @buyer_listing.user
                else
                    @seller = @seller_listing.user
                end
            
                # create the transaction
                         
                @t = Transaction.new
                @t.buyer_id = @buyer.id
                @t.seller_id = @seller.id
                @t.buyer_listing_id = @buyer_listing.id
                @t.seller_listing_id = @seller_listing.id
                @t.state = 0
                
                # get phone numbers              
                
                bnums = @buyer.nums.dup
                @t.buyer_number_id = bnums.index('0')
                bnums[@t.buyer_number_id] = '1'
                @buyer.nums = "#{bnums}".to_s
                @buyer.save
                
                snums = @seller.nums.dup
                @t.seller_number_id = snums.index('0')
                snums[@t.seller_number_id] = '1'
                @seller.nums = "#{snums}".to_s
                @seller.save
                
                # save listing
                
                fail = !@t.save
                
                @buyer_listing.pending = true
                @seller_listing.pending = true
                @buyer_listing.save
                @seller_listing.save
                
                # send message to buyer
                
                sender = Contact.new('Skoole', "#{@t.id}@skoole.com", Number.find(@t.buyer_number_id).number)
                receiver = Contact.new('Ryan', @buyer.email, @buyer.sms)
                message = Message.new(sender, receiver, @t)

                sms_response = Nexmo.send(message)
                puts sender.inspect, receiver.inspect
                puts sms_response.body, sms_response.code, sms_response.message, sms_response.headers.inspect

                email_response = Sendgrid.send(message)
                puts email_response.body, email_response.code, email_response.message, email_response.headers.inspect
               
            else
                
                puts "NO MATCH :("
                
            end
            
        end
        
        respond_to do |format|          
            format.js
            format.html { redirect_to '/lists' }
        end
        
    end
  
end
