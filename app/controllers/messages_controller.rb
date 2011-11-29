require 'rubygems'
require 'httparty'

require 'contents'

class MessagesController < ApplicationController

    def sms_in                        
        from = params[:msisdn]
        to = params[:to]
        msg = params[:text]
        puts puts "RECEIVED SMS from #{from} to #{to}: \"#{msg}\""

        # a test number (just forward it on to ryan)
        if to == '12064532948'
            sms = Sms.new(
                message_id: 0,
                from_address: '12064532948',
                to_address: '18457026112',
                content: "FW: #{msg}"
            )
            puts 'Sending to dummy number'
            sms.broadcast_now
            render nothing: true and return
        end

        sender = User.find_by_sms(from)
        number = Number.find_by_number(to)

        # if numbers are valid
        if sender && number
            puts 'This message is from a valid user'

            # find the match and respond
            if match = Match.locate_via_sender(sender, number)
                match.respond(sender, msg)
            else
                puts "COULD NOT FIND A VALID MATCH"
                puts "sender_id: #{sender.id}"
                puts "number_id: #{number.id}"
                # TODO should send an error message back to the user
                render nothing: true and return
            end
        else
            puts 'This message is from/to an unknown number'
        end
        
        render nothing: true
    end
    
    def email_in
    end

end
