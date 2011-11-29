class UsersController < ApplicationController
    
    def show
    end
    
    # AUTH
    
    def connect
        @current_user = User.find_by_f_id(params[:f_id]) if params[:f_id]
        session[:user_id] = @current_user.id if @current_user
        if @current_user && @current_user.ready
            redirect_to listings_path and return
        else
            render 'auth'
        end
    end
    
    def callback
        if params[:error_reason]
            redirect_to root_url
        else
           fb_params = request.env["omniauth.auth"]
           user = User.create_with_facebook(fb_params)
           session[:user_id] = user.id
        end
    end
    
    def authorized
        if @current_user && @current_user.member
            redirect_to listings_path
        elsif @current_user.ready
            render 'soon'
        elsif @current_user
            render 'signup'
        else
            redirect_to root_url
        end
    end
    
    def logout
        @current_user = nil
        session[:user_id] = nil
        redirect_to root_url
    end
    
    # EDITS
    
    def update
        @current_user.update_attributes(params[:user])
        redirect_to :action => :authorized
    end

    def destroy
        current_user.destroy
        session[:user_id] = nil
        redirect_to root_url
    end
    
end