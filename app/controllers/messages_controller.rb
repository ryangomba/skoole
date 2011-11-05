require 'rubygems'
require 'httparty'

require 'message'

class MessagesController < ApplicationController

    def in
        puts 'recieved'
        from = params[:msisdn]
        to = params[:to]
        text = params[:text]
        puts from, to, text
        
        @sender = User.where("sms = '#{from}'").first
        @number = Number.where("number = '#{to}'")
        @t = Transaction.where("buyer_number_id = '#{@number.id}' AND buyer_id = #{@sender.id}").first
        if !@t
            @t = Transaction.where("seller_number_id = '#{@number.id}' AND seller_id = #{@sender.id}").first
        end
        
        if @t
            puts "WE GOT A TRANSACTION!!!!!!!!!!!!"
            
            @t.state += 1
            
            
        end
        
        render :text => ""
    end

end
