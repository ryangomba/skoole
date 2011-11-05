class AddUsers < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :name
            t.string :email
            t.string :sms
            t.string :provider
            t.string :uid

            t.timestamps
        end
    end
end
