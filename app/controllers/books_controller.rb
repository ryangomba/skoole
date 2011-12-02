class BooksController < ApplicationController
    layout false, :only => :your_action_name 
   
    def show
        @book = Book.find(params[:id])
    end
    
end
