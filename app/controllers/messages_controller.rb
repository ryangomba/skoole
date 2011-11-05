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
        
        render :text => ""
    end

end
