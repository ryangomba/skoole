require 'rubygems'
require 'httparty'

require 'contents'

class MessagesController < ApplicationController

    def out
        from = Number.find(1)
        user = User.find_by_sms('18457026112')
        
        message = Message.new
        message.sms = from
        message.set_contents(Contents.new('Subject', 'Short', 'Long'))
        
        user.send(message)
        render nothing: true
    end

    def in
        from = params[:msisdn]
        to = params[:to]
        text = params[:text]
        puts puts 'RECEIVED SMS', from, to, text

        sender = User.find_by_sms(from)
        number = Number.find_by_number(to)

        # if numbers are valid
        if sender && number

            # find the match
            t = Match.find_by_buyer_id_and_buyer_number_id(number.id, sender.id)
            if t.nil? then t = Match.find_by_seller_id_and_seller_number_id(number.id, sender.id) end

            # if we couldn't find a match, send an error
            if t.nil?
                puts "COULD NOT FIND A VALID MATCH"
                sender.send_error(to, error_message)
                render nothing: true
                break
                
            # otherwise, respond
            else
                t.respond(sender, text, to)
            end
            
        end
        
        render nothing: true
    end

end
