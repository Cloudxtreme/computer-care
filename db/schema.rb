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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131104201130) do

  create_table "admins", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "invoices", force: true do |t|
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "newsletter_users", force: true do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_service_options", force: true do |t|
    t.integer  "order_service_id"
    t.text     "value"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "service_option_id"
  end

  create_table "order_services", force: true do |t|
    t.integer  "order_id"
    t.integer  "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "telephone"
    t.string   "building"
    t.string   "street"
    t.string   "town"
    t.string   "postcode"
    t.datetime "date"
    t.decimal  "total_cost",       precision: 10, scale: 0
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "paid"
    t.integer  "student_code_id"
    t.boolean  "agreed_to_terms"
    t.string   "stripe_charge_id"
  end

  create_table "service_option_values", force: true do |t|
    t.string   "name"
    t.integer  "service_option_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.float    "additional_cost",   default: 0.0
  end

  create_table "service_options", force: true do |t|
    t.string   "name"
    t.boolean  "is_arbitrary"
    t.integer  "service_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "placeholder"
    t.string   "label"
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.float    "base_cost"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "can_checkout"
  end

  create_table "student_codes", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "code"
    t.boolean  "is_valid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tips", force: true do |t|
    t.text     "body"
    t.boolean  "published"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
