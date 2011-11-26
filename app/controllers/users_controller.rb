class UsersController < ApplicationController
    
    def show
    end
   
    def create
        puts "CREATING", params.inspect
        if params[:error_reason].nil?
            fb_params = request.env["omniauth.auth"]
            #puts fb_params.inspect
            user = User.create_with_facebook(fb_params)
            session[:user_id] = user.id
        end
        redirect_to root_url, notice: "User created & signed in."
    end

    def update
        @user = current_user
        @user.update_attributes(params[:user])
    end

    def destroy
        current_user.destroy
        session[:user_id] = nil
        redirect_to root_url, notice: "User deleted & signed out."
    end
    
end