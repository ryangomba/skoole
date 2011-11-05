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
    end
    
    def account
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

