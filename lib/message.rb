class Contact
    
    attr_reader :name, :email, :sms
    
    def initialize(name, email, sms)
        @name = name
        @email = email
        @sms = sms
    end
    
end

class Message
    
    attr_reader :sender, :receiver, :kind
    
    def initialize(sender, receiver, kind)
        @sender = sender
        @receiver = receiver
        @kind = kind
    end
    
    def subject
        'Test Subject'
    end
    
    def body
        'Test Body'
    end
    
end