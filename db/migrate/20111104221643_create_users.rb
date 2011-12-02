class CreateUsers < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :first_name
            t.string :last_name
            t.string :image
            t.string :email
            t.string :network
            t.string :sms
            
            t.string :nums, default: '0000000000'
            
            t.boolean :sms_enabled, default: true
            t.boolean :email_enabled, default: true
            
            t.string :f_id
            t.string :f_token
            t.string :f_username

            t.timestamps
        end
    end
end
