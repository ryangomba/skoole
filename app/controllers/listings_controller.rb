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
        puts "sending message from #{message.sender.sms} to #{message.receiver.sms}"
        get('/sms/json', :query => {
            :from => message.sender.sms,
            :to => message.receiver.sms,
            :text => message.body
        })
    end
    def self.trade(message, text)
        get('/sms/json', :query => {
            :from => message.sender.sms,
            :to => message.receiver.sms,
            :text => text
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
    def self.trade(message, text)
        get('/mail.send.json', :query => {
            :from => message.sender.email,
            :fromname => message.sender.name,
            :to => message.receiver.email,
            :toname => message.receiver.name,
            :subject => message.subject,
            :text => text
        })
    end
end

class ListingsController < ApplicationController

    def in
        puts 'recieved'
        from = params[:msisdn]
        to = params[:to]
        text = params[:text]
        puts from, to, text
        
        @sender = User.where("sms = '#{from}'").first
        @number = Number.where("number = '#{to}'").first

	if @sender && @number

        puts "sender and number found"
        @t = Transaction.where("buyer_number_id = '#{@number.id}' AND buyer_id = '#{@sender.id}'").first
        if !@t
            @t = Transaction.where("seller_number_id = '#{@number.id}' AND seller_id = '#{@sender.id}'").first
        end
        
        if @t
            yesno = text.downcase[0].chr == 'y'       

            if @t.state == 0
                puts "send message to buyer asking for confirmation"
                if yesno
                    @t.state = 1
                    puts "YES!"
                    sknumber = Number.find(@t.seller_number_id).number
                    sen = Contact.new('Skoole', "#{@t.id}@skoole.com", sknumber)
                    seller = User.find(@t.seller_id)
                    rec = Contact.new(seller.firstname, seller.email, seller.sms)
                else
                    @t.state = 9
                    sen = Contact.new('Skoole', "#{@t.id}@skoole.com", to)
                    rec = Contact.new(buyer.firstname, buyer.email, buyer.sms)
                end
                m = Message.new(sen, rec, @t)
                Nexmo.send(m)
                Sendgrid.send(m)

            elsif @t.state == 1
                puts "send message to seller asking for confirmation"
                if yesno
                    puts "sending instructions to both parties"
                    @t.state = 2
                    puts "YES!"
                    # sending instructions back to seller
                    seller = User.find(@t.seller_id)
                    sen = Contact.new('Skoole', "#{@t.id}@skoole.com", to)
                    rec = Contact.new(seller.firstname, seller.email, seller.sms)
                    m1 = Message.new(sen, rec, @t)
                    r1 = Nexmo.send(m1)
                    Sendgrid.send(m1)
                    puts r1.inspect
                    # sending instructions to buyer
                    sknumber = Number.find(@t.buyer_number_id).number
                    sen = Contact.new('Skoole', "#{@t.id}@skoole.com", sknumber)
                    buyer = User.find(@t.buyer_id)
                    rec = Contact.new(buyer.firstname, buyer.email, buyer.sms)
                    m2 = Message.new(sen, rec, @t)
                    sleep(1)
                    r2 = Nexmo.send(m2)
                    Sendgrid.send(m2)
                    @t.state = 3
                    puts r2.inspect
                else
                    pass
                end

            elsif @t.state == 3
                puts "trading"
                seller = User.find(@t.seller_id)
                buyer = User.find(@t.buyer_id)
                if buyer.sms == from
                    sknumber = Number.find(@t.seller_number_id).number
                    r = User.find(@t.seller_id)
                else
                    sknumber = Number.find(@t.buyer_number_id).number
                    r = User.find(@t.buyer_id)
                end
                rec = Contact.new(r.firstname, r.email, r.sms)
                sen = Contact.new('Skoole', "#{@t.id}@skoole.com", sknumber)
                m = Message.new(sen, rec, @t)
                Nexmo.trade(m, text)
                Sendgrid.trade(m, text)
            end

            puts "WE GOT A TRANSACTION!!!!!!!!!!!!"
            puts @t.inspect

            @t.save
        end
    end
        
        render :text => ""
    end
















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
                @latest_entry = current_user.listings.where(:kind => 'Buy').last 
           else
                @seller = current_user
                @seller_listing = @listing
                @buyer_listing = Listing.where("book_id = ? AND pending = ? AND kind = 'Buy' AND price >= ? AND condition >= ? AND id < ?",
                    @listing.book_id, false, @listing.price, @listing.condition, @listing.id
                ).order('created_at ASC').first
                @latest_entry = current_user.listings.where(:kind => 'Sell').last
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
                @t.buyer_number_id = bnums.index('0') + 1
                bnums[@t.buyer_number_id - 1] = '1'
                @buyer.nums = "#{bnums}".to_s
                @buyer.save
                
                snums = @seller.nums.dup
                @t.seller_number_id = snums.index('0') + 1
                snums[@t.seller_number_id - 1] = '1'
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
                receiver = Contact.new(@buyer.name, @buyer.email, @buyer.sms)
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
