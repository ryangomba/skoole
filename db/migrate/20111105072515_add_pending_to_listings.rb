class AddPendingToListings < ActiveRecord::Migration
    
    def up
        add_column :listings, :pending, :boolean, :default => false
    end
    
    def down
        remove_column :listing, :pending
    end

end
