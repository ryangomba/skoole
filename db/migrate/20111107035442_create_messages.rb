class CreateMessages < ActiveRecord::Migration
    def change
        create_table :messages do |t|
            t.integer :match_id # the transaction
            t.integer :user_id # the receiver
            t.integer :sms # sms gateway
            t.string :subject
            t.text :short
            t.text :long

            t.timestamps
        end
    end
end
