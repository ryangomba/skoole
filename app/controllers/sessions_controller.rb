require 'auth'

class SessionsController < ActionController::Base
   
    def create
        response = parse_signed_request(request.env["omniauth.params"]["signed_request"])["registration"]
        #puts response["registration"]["name"], response["registration"]["phone"], response["registration"]["email"], response["oauth_token"]
        auth = request.env["omniauth.auth"]
        
        user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth, response)
        session[:user_id] = user.id
        redirect_to '/lists'
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Signed out!"
    end

    def autofb
        fid = params[:session][:uid]
        puts fid
        #if !current_user
            @user = User.where(:uid => fid).first
            if @user then session['user_id'] = @user.id end
        #end
    
        respond_to do |format|
            format.js
        end
    end
    
end
