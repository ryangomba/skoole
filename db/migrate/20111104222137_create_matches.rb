class CreateMatches < ActiveRecord::Migration
    def change
        create_table :matches do |t|
            t.integer :buyer_id
            t.integer :seller_id
            t.integer :buyer_number_id
            t.integer :seller_number_id
            t.integer :buyer_listing_id
            t.integer :seller_listing_id
            t.integer :state

            t.timestamps
        end
    end
end
