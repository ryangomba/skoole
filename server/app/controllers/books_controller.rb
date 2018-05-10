class BooksController < ApplicationController
    layout false, :only => :your_action_name 
   
    def show
        if params[:fb_action_ids]
            redirect_to root_url
        end
        @book = Book.find(params[:id])
    end
    
end
