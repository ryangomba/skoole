require 'api/nexmo'
require 'api/sendgrid'
require 'contents'

class Match < ActiveRecord::Base
    
    has_one :buyer, class_name: User, foreign_key: "buyer_id"
    has_one :seller, class_name: User, foreign_key: "seller_id"
    
    has_one :buyer_number, class_name: Number, foreign_key: "buyer_number_id"
    has_one :seller_number, class_name: Number, foreign_key: "seller_number_id"
    
    has_one :buyer_listing, class_name: Listing, foreign_key: "buyer_id"
    has_one :seller_listing, class_name: Listing, foreign_key: "seller_number_id"
    
    validates_presence_of :buyer_id, :seller_id, :buyer_number_id, :seller_number_id, :buyer_listing_id, :seller_listing_id, :state
    
    ##### MESSAGING
    
    def respond(sender, text, rec_num)
        
        yesno = text.downcase[0].chr == 'y'

        # if the message is from a potential buyer
        if self.state == 0 && sender.id == self.buyer_id
            
            puts "Received message from buyer re: confirmation"
            if yesno
                puts "Buyer wants to buy! We'll check with the seller..."
                seller = User.find(self.seller_id)
                sknumber = Number.find(self.seller_number_id).number
                contents = contents_for_match(self, text)
                message = Message.create
                seller.send_sms(sknumber, message, t.id)
                self.state = 1
                self.save
            else
                puts "Buyer has declined :( We'll respond & mark the match as canceled."
                message = make_message(self, text)
                sender.send(rec_num, message)
                self.state = 9
                self.save
            end
            m = Message.new(sen, rec, @t)
            Nexmo.send(m)
            Sendgrid.send(m)

        elsif self.state == 1
            
            puts "Received message from seller re: confirmation"
            if yesno
                puts "Seller confirmed! Sending instructions to both parties..."
                self.state = 2
                # sending instructions back to seller
                seller = User.find(self.seller_id)
                sen = Contact.new('Skoole', "#{self.id}@skoole.com", to)
                rec = Contact.new(seller.firstname, seller.email, seller.sms)
                m1 = Message.new(sen, rec, @t)
                r1 = Nexmo.send(m1)
                Sendgrid.send(m1)
                puts "Seller instructions: " + r1.inspect
                # sending instructions to buyer
                sknumber = Number.find(self.buyer_number_id).number
                sen = Contact.new('Skoole', "#{self.id}@skoole.com", sknumber)
                buyer = User.find(self.buyer_id)
                rec = Contact.new(buyer.firstname, buyer.email, buyer.sms)
                m2 = Message.new(sen, rec, @t)
                sleep(1)
                r2 = Nexmo.send(m2)
                Sendgrid.send(m2)
                self.state = 3
                puts "Buyer instructions: " + r2.inspect
            else
                pass
            end

        elsif self.state == 3
            puts "Users trading messages"
            seller = User.find(self.seller_id)
            buyer = User.find(self.buyer_id)
            if buyer.sms == from
                sknumber = Number.find(self.seller_number_id).number
                r = User.find(self.seller_id)
            else
                sknumber = Number.find(self.buyer_number_id).number
                r = User.find(self.buyer_id)
            end
            rec = Contact.new(r.firstname, r.email, r.sms)
            sen = Contact.new('Skoole', "#{self.id}@skoole.com", sknumber)
            m = Message.new(sen, rec, @t)
            Nexmo.trade(m, text)
            Sendgrid.trade(m, text)
        end

        puts "WE GOT A MATCH!"
        puts "Match hash: " + self.inspect

        self.save
        
    end
    
end