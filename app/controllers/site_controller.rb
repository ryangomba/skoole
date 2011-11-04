require 'rubygems'
require 'httparty'

class TestRequest
  include HTTParty
  def send
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
        response = TestRequest.send()
        puts sms_response.body, sms_response.code, sms_response.message, sms_response.headers.inspect
        
        @test ='haha'
        
        respond_to do |format|
            format.js { render :nothing => true }
        end
    end

end
