class AddListings < ActiveRecord::Migration
    def change
        create_table :listings do |t|
            t.string :kind
            t.integer :user_id
            t.integer :book_id
            t.integer :price
            t.string :condition

            t.timestamps
        end
    end
end
