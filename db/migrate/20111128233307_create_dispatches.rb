class CreateDispatches < ActiveRecord::Migration
    def change
        create_table :dispatches do |t|
            t.string :type
            t.integer :message_id
            
            t.string :from_address
            t.string :to_address
            t.text :content
            t.string :service
            
            # EMAIL ONLY
            
            t.string :from_name
            t.string :to_name
            t.string :subject

            t.timestamps
        end
    end
end
