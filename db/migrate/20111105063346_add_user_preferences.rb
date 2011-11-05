class AddUserPreferences < ActiveRecord::Migration
    
    def up
        add_column :users, :sms_enabled, :boolean, :default => 1
        add_column :users, :email_enabled, :boolean, :default => 1
    end
    
    def down
        remove_column :users, :sms_enabled
        remove_column :users, :email_enabled
    end
    
end
