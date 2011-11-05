require 'auth'

class SessionsController < ApplicationController
   
    def create
        response = parse_signed_request(request.env["omniauth.params"]["signed_request"])["registration"]
        #puts response["registration"]["name"], response["registration"]["phone"], response["registration"]["email"], response["oauth_token"]
        auth = request.env["omniauth.auth"]
        
        user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth, response)
        session[:user_id] = user.id
        redirect_to root_url, :notice => "Signed in!"
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Signed out!"
    end
    
end