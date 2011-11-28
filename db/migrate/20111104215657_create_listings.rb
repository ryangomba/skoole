class CreateListings < ActiveRecord::Migration
    def change
        create_table :listings do |t|
            t.string :type
            t.integer :user_id
            t.string :network
            t.integer :book_id
            t.integer :price
            t.string :condition
            t.boolean :pending, default: false

            t.timestamps
        end
    end
end
