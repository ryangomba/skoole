class Match < ActiveRecord::Base
    
    belongs_to :buyer, class_name: 'User', foreign_key: "buyer_id"
    belongs_to :seller, class_name: 'User', foreign_key: "seller_id"
    
    belongs_to :buyer_number, class_name: 'Number', foreign_key: "buyer_number_id"
    belongs_to :seller_number, class_name: 'Number', foreign_key: "seller_number_id"
    
    belongs_to :buyer_listing, class_name: 'BuyListing', foreign_key: "buyer_listing_id"
    belongs_to :seller_listing, class_name: 'SellListing', foreign_key: "seller_listing_id"
    
    has_many :messages
    
    validates_presence_of :buyer_id, :seller_id, :buyer_number_id, :seller_number_id, :buyer_listing_id, :seller_listing_id, :state, :network
    
    ##### MESSAGING
    
    # the first message
    def first_message
        self.confirm_with_buyer
    end
    
    # confirm with the buyer
    def confirm_with_buyer
        
        puts 'Creating buyer confirmation message'
        seller_name = self.seller.first_name
        if self.friendly then seller_name = "your friend #{self.seller.full_name}" end
        book_title = self.seller_listing.book.title.titleize
        price = self.seller_listing.price
        msg = self.messages.create(
            user_id: self.buyer_id,
            subject: "We found a match!",
            short: "Would you like to purchase #{book_title} from #{seller_name} for $#{price}?",
            full: "Would you like to purchase #{book_title} from #{seller_name} for $#{price}?"
        )
        msg.dispatch
    end
    
    # confirm with the seller
    def confirm_with_seller
        puts 'Creating seller confirmation message'
        buyer_name = self.buyer.first_name
        if self.friendly then buyer_name = "your friend #{self.buyer.full_name}" end
        book_title = self.seller_listing.book.title.titleize
        price = self.seller_listing.price
        
        msg = self.messages.create(
            user_id: self.seller.id,
            subject: "We found a match!",
            short: "Would you like to sell #{book_title} to #{buyer_name} for $#{price}?",
            full: "Would you like to sell #{book_title} to #{buyer_name} for $#{price}?"
        )
        msg.dispatch
    end
    
    # confirm the match
    def confirm_matched
        puts 'Creating match confirmation message'
        msg1 = self.messages.create(
            user_id: self.buyer.id,
            subject: "Your match is set!",
            short: "Alrighty, you're all set! Use this number to arrange when & where to meet. You should send the first message.",
            full: "Alrighty, you're all set! Use this number to arrange when & where to meet. You should send the first message."
        )
        msg2 = self.messages.create(
            user_id: self.seller.id,
            subject: "Your match is set!",
            short: "Alrighty. You're all set! Use this number to arrange when & where to meet. #{self.buyer.first_name} will contact you first.",
            full: "Alrighty. You're all set! Use this number to arrange when & where to meet. #{self.buyer.first_name} will contact you first."
        )
        msg1.dispatch
        msg2.dispatch
    end
    
    # confirm the match has been canceled
    def confirm_canceled
        puts 'Creating cancelation confirmation message'
        msg1 = self.messages.create(
            user_id: self.buyer.id,
            subject: "Match canceled.",
            short: "This match has been canceled. No worries; you're back in the queue! :)",
            full: "This match has been canceled. No worries; you're back in the queue! :)"
        )
        msg2 = self.messages.create(
            user_id: self.seller.id,
            subject: "Match canceled.",
            short: "This match has been canceled. No worries; you're back in the queue! :)",
            full: "This match has been canceled. No worries; you're back in the queue! :)"
        )
        msg1.dispatch
        msg2.dispatch
    end
    
    # trade a message
    def trade_message(recipient_id, sender_name, msg)
        puts 'Relaying user messsage'
        book_title = self.seller_listing.book.title.titleize
        
        msg = self.messages.create(
            user_id: recipient_id,
            subject: "You have a message regarding #{book_title}!",
            short: "#{sender_name} says: #{msg}",
            full: "#{sender_name} says: #{msg}"
        )
        msg.dispatch
    end
    
    ##### MESSAGE LOGIC
    
    def respond_to_sms(sender, msg)
        
        yesno = msg.downcase[0].chr == 'y'

        # if the message is from a buyer
        if self.state == 0 && sender.id == self.buyer_id
            
            puts "Received message from buyer re: confirmation"
            if yesno
                puts "Buyer wants to buy! We'll check with the seller..."
                self.confirm_with_seller
                self.state = 1
                self.save
            else
                puts "Buyer has declined :( We'll respond & mark the match as canceled."
                self.confirm_canceled
                self.state = 9
                self.save
            end

        # if the message is from a seller
        elsif self.state == 1 && sender.id == self.seller_id
            
            puts "Received message from seller re: confirmation"
            if yesno
                puts "Seller confirmed! Sending instructions to both parties..."
                self.confirm_matched
                self.state = 2
                self.save
            else
                puts "Seller has declined :( We'll respond & mark the match as canceled."
                self.confirm_canceled
                self.state = 9
                self.save
            end

        # if the message is part of a conversation
        elsif self.state == 2 && recipient = self.other_user(sender)
            
            trade_message(recipient.id, sender.first_name, msg)
        
        # if the message didn't match any condition
        else
            
            # TODO should send an error message
            puts "Message unexpected (state didn't match)"
            
        end
        
    end
    
    def respond_to_voice(sender, msg)
        
        if self.state == 2 && recipient = self.other_user(sender)
            puts "sender is #{sender.first_name} and recipient is #{recipient.first_name}"
            return number_for_user_id(recipient).number, recipient.sms
        end
        
    end
    
    ##### HELPERS
    
    def self.locate_via_sender(sender, number)
        m = find_by_buyer_id_and_buyer_number_id(sender.id, number.id)
        if m.nil? then m = find_by_seller_id_and_seller_number_id(sender.id, number.id) end
        return m
    end
    
    def role(user)
        if user.id == self.seller_id then return 'sold' end
        return 'bought'
    end
    
    def other_user(user)
        if user.id == self.buyer.id
            return self.seller
        elsif user.id == self.seller.id
            return self.buyer
        end
        return nil
    end
    
    def number_for_user_id(user_id)
        if user_id == self.buyer_id then return self.buyer_number end
        return self.seller_number
    end
    
    def price
        return self.seller_listing.price
    end
    
    def savings
        10
    end
    
end
