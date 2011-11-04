class AddUsers < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :name
            t.string :email
            t.string :sms
            t.string :f_id

            t.timestamps
        end
    end
end
