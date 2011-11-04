class AddNumbers < ActiveRecord::Migration
    def change
        create_table :numbers do |t|
            t.string :number

            t.timestamps
        end
    end
end
