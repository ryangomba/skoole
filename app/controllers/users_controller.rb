class UsersController < ApplicationController
    
    def show
    end
   
    def create
        fb_params = request.env["omniauth.auth"]
        #puts fb_params.inspect
        user = User.create_with_facebook(fb_params)
        session[:user_id] = user.id
        redirect_to root_url, notice: "User created & signed in."
    end

    def update
        @user = current_user
        @user.update_attributes(params[:user])
        respond_to do |format|
            format.js
        end
    end

    def destroy
        current_user.destroy
        session[:user_id] = nil
        redirect_to root_url, notice: "User deleted & signed out."
    end
    
end