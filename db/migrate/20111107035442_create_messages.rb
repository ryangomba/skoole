class CreateMessages < ActiveRecord::Migration
    def change
        create_table :messages do |t|
            t.integer :match_id
            t.integer :user_id
            t.string :subject
            t.text :short
            t.text :long

            t.timestamps
        end
    end
end
