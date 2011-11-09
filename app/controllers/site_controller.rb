class SiteController < ApplicationController

    def welcome
    end
    
    def login
        @current_user ||= User.find_by_f_id(params[:f_id]) if params[:f_id]
        session[:user_id] = @current_user.id if @current_user
        if @current_user
            puts 'we have a user'
            redirect_to '/'
        else
            puts 'no user. to facebook ->'
            redirect_to '/auth/facebook'
        end
    end
    
    def autologin
        session[:f_id] = params[:session][:uid]
        render :nothing => true
    end
    
    def logout
        session[:user_id] = nil
        redirect_to root_url, notice: "User signed out!"
    end
  
    ##
    
    def test
        @current_user.test
        redirect_to root_url, notice: "API request finished."
    end
  
end

