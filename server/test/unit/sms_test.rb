require 'test_helper'

class SmsTest < ActiveSupport::TestCase

    test "nexmo" do
        sms = Sms.new(
            message_id: 0,
            from_address: '12064532171',
            to_address: '18457026112',
            content: 'Nexmo sms test',
            service: 'Nexmo'
        )
        assert sms.broadcast_now, "Couldn't send Nexmo SMS."
    end

    test "twilio" do
        sms = Sms.new(
            message_id: 0,
            from_address: '14044482984',
            to_address: '18457026112',
            content: 'Twilio sms test',
            service: 'Twilio'
        )
        assert sms.broadcast_now, "Couldn't send Twilio SMS."
    end

end
