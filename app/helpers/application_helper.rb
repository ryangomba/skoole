module ApplicationHelper
    
    def listings_link
        @current_user ? listings_path : '#'
    end
    
    def matches_link
        @current_user ? matches_path : '#'
    end

end