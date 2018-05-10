class Message < ActiveRecord::Base

    belongs_to :match
    belongs_to :user

    has_many :dispatches
    has_many :emails
    has_many :smses

    validates_presence_of :match_id, :user_id, :subject, :short, :full

    def dispatch
        if self.user.sms_enabled then self.queue_sms end
        #if self.user.email_enabled then self.queue_email end
    end

    def queue_sms
        puts 'Dispatching an SMS message'
        d = self.smses.create(
        from_address: self.match.number_for_user_id(self.user_id).number,
        to_address: self.user.sms,
        content: self.short
        )
        d.broadcast
    end

    def queue_email
        puts 'Dispatching an email message'
        d = self.emails.create(
        from_name: 'Skoole.com',
        from_address: "match-#{self.match_id}@skoole.com}",
        to_name: self.user.full_name,
        to_address: self.user.email,
        subject: self.subject,
        content: self.full
        )
        d.broadcast
    end

    def self.process_incoming(from, to, msg, kind)
        if kind == 'sms'
            puts "RECEIVED SMS from #{from} to #{to}: \"#{msg}\""
        else
            puts "RECEIVED voice call from #{from} to #{to}: \"#{msg}\""
        end
        
        sender = User.find_by_sms(from)
        number = Number.find_by_number(to)

        # if numbers are valid
        if sender && number
            puts 'This message is from a valid user'

            # find the match and respond
            if match = Match.locate_via_sender(sender, number)
                if kind == 'sms' then return match.respond_to_sms(sender, msg) end
                return match.respond_to_voice(sender, msg)
            else
                puts "COULD NOT FIND A VALID MATCH"
                puts "sender_id: #{sender.id}"
                puts "number_id: #{number.id}"
                # TODO should send an error message back to the user
            end
        else
            puts 'This message is from/to an unknown number'
        end
    end

end
