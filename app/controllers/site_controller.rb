class SiteController < ApplicationController

    def welcome
    end
    
    def login
        @current_user = User.find_by_f_id(params[:f_id]) if params[:f_id]
        session[:user_id] = @current_user.id if @current_user
        if @current_user
            respond_to do |format|
                format.js
            end
        else
            respond_to do |format|
                format.js { render :auth }
            end
        end
    end
    
    def logout
        session[:user_id] = nil
        redirect_to root_url, notice: "User signed out."
    end
  
end
