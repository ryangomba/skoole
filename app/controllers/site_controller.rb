class SiteController < ApplicationController

    def welcome
    end
    
    def login
        @current_user = User.find_by_f_id(params[:f_id]) if params[:f_id]
        session[:user_id] = @current_user.id if @current_user
        if @current_user.nil?
            render :auth
        end
    end
    
    def logout
        @current_user = nil
        session[:user_id] = nil
        render :login
    end
  
end
