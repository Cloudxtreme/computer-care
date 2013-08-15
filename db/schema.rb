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

ActiveRecord::Schema.define(:version => 20130815225711) do

  create_table "newsletter_users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "service_option_values", :force => true do |t|
    t.string   "name"
    t.integer  "service_option_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.float    "additional_cost",   :default => 0.0
  end

  create_table "service_options", :force => true do |t|
    t.string   "name"
    t.boolean  "is_arbitrary"
    t.integer  "service_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.float    "base_cost"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "can_checkout"
  end

  create_table "student_codes", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "code"
    t.boolean  "is_valid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
