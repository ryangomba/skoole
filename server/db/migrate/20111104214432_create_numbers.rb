class CreateNumbers < ActiveRecord::Migration
    def change
        create_table :numbers do |t|
            t.string :number
            t.integer :index

            t.timestamps
        end
    end
end
