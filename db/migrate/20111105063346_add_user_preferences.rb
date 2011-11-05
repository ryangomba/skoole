class AddUserPreferences < ActiveRecord::Migration
    
    def up
        add_column :users, :sms_enabled, :boolean, :default => true
        add_column :users, :email_enabled, :boolean, :default => true
    end
    
    def down
        remove_column :users, :sms_enabled
        remove_column :users, :email_enabled
    end
    
end
