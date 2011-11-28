# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111128233307) do

  create_table "books", :force => true do |t|
    t.string   "isbn"
    t.string   "title"
    t.string   "author"
    t.string   "thumbnail"
    t.string   "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "dispatches", :force => true do |t|
    t.string   "type"
    t.integer  "message_id"
    t.string   "from_address"
    t.string   "to_address"
    t.text     "content"
    t.string   "from_name"
    t.string   "to_name"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.string   "network"
    t.integer  "book_id"
    t.integer  "price"
    t.string   "condition"
    t.boolean  "pending",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.integer  "buyer_number_id"
    t.integer  "seller_number_id"
    t.integer  "buyer_listing_id"
    t.integer  "seller_listing_id"
    t.integer  "state"
    t.string   "network"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.string   "subject"
    t.text     "short"
    t.text     "long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "numbers", :force => true do |t|
    t.string   "number"
    t.integer  "index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image"
    t.string   "email"
    t.string   "network"
    t.string   "sms"
    t.string   "nums",          :default => "0000000000"
    t.boolean  "sms_enabled",   :default => true
    t.boolean  "email_enabled", :default => true
    t.string   "f_id"
    t.string   "f_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
