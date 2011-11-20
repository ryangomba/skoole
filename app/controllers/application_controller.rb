class ApplicationController < ActionController::Base
    protect_from_forgery
    respond_to :js
    
    before_filter :current_user
    private
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
end
