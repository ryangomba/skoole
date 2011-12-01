xml.instruct!
xml.Response do
    xml.Say "Redirecting."
    xml.Dial(@redirect_2, callerId:"#{@redirect_1}")
end
