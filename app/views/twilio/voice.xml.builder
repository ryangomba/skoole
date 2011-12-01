xml.instruct!
xml.Response do
    xml.Say "Redirecting."
    xml.Dial(@redirect_2, callerId:"14049961853")
end
