require 'test_helper'

class SmsTest < ActiveSupport::TestCase

    test "send" do
        sms = Sms.new(
            message_id: 0,
            from_address: '12064532171',
            to_address: '18457026112',
            content: 'SMS unit test'
        )
        assert sms.broadcast, "Couldn't send SMS."
    end

end
