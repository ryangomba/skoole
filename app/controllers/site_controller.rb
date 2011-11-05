require 'rubygems'
require 'httparty'
require 'json'

class TestRequest
  include HTTParty
  def self.send
      get('http://apple.com', :query => {
          :foo => 'bar'
      })
  end
end

class SiteController < ApplicationController

    def index
    end
    
    def lists
        @buying = current_user.listings.where(:kind => 'Buy')
        @selling = current_user.listings.where(:kind => 'Sell')
    end
    
    def account
        @user = current_user
    end
    
    def test
    end
    
    def test_request
        response = TestRequest.send
        @test = "haha"
        
        respond_to do |format|
            format.js 
        end
    end
  
end

