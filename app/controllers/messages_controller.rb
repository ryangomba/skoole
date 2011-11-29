require 'rubygems'
require 'httparty'

require 'contents'

class MessagesController < ApplicationController

    def sms_in
        from = params[:msisdn]
        to = params[:to]
        msg = params[:text]
        puts puts "RECEIVED SMS from #{from} to #{to}: \"#{msg}\""

        sender = User.find_by_sms(from)
        number = Number.find_by_number(to)

        # if numbers are valid
        if sender && number
            puts 'This message is from a valid user'

            # find the match and respond
            if match = Match.locate_via_sender(sender, number)
                t.respond(sender, text, to)
            else
                puts "COULD NOT FIND A VALID MATCH"
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
