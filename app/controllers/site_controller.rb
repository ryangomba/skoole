class SiteController < ApplicationController

    def welcome
    end
    
    def login
        redirect_to '/auth/facebook'
    end
    
    def logout
        session[:user_id] = nil
        redirect_to root_url, :notice => "User signed out!"
    end
  
    ##
    
    def test
        @current_user.test
        redirect_to root_url, :notice => "API request finished."
    end
  
end

