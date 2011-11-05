class UsersController < ApplicationController
   
   def update
       @user = current_user
       @user.update_attributes(params[:user])
       
       respond_to do |format|
           format.js
           format.html { redirect_to '/account' }
       end
   end
    
end