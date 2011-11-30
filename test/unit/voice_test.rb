require 'test_helper'

class VoiceTest < ActiveSupport::TestCase

    test "twilio" do
        sms = Voice.new(
            message_id: 0,
            from_address: '14044482984',
            to_address: '18457026112',
            content: 'Twilio sms test',
            service: 'Twilio'
        )
        assert sms.broadcast_now, "Couldn't send Twilio SMS."
    end

end
