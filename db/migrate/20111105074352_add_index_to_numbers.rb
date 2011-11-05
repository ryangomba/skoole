class AddIndexToNumbers < ActiveRecord::Migration

    def up
        add_column :numbers, :index, :integer
    end
    
    def down
        remove_column :numbers, :index
    end

end
