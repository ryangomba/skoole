require 'test_helper'

class EmailTest < ActiveSupport::TestCase

    test "send" do
        email = Email.new(
            message_id: 0,
            from_address: 'desk@skoole.com',
            from_name: 'Skoole',
            to_address: 'ryan@ryangomba.com',
            to_name: 'Ryan',
            subject: 'Testing, testing, 1-2-3',
            content: 'This is an email unit test.'
        )
        assert email.broadcast, "Couldn't send email."
    end

end
