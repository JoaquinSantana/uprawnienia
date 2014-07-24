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

ActiveRecord::Schema.define(version: 20140723084955) do

  create_table "areas", force: true do |t|
    t.string   "nazwa"
    t.integer  "order_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
  end

  create_table "areas_order_items", force: true do |t|
    t.integer "area_id"
    t.integer "order_item_id"
  end

  create_table "branches", force: true do |t|
    t.string   "nazwa"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branches_order_items", id: false, force: true do |t|
    t.integer "branch_id"
    t.integer "order_item_id"
  end

  create_table "decisions", force: true do |t|
    t.integer  "order_id"
    t.boolean  "opinia"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "status",       limit: 255, default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wnioskujacy"
    t.text     "kordkom"
    t.boolean  "dane_osobowe",             default: false
    t.boolean  "uprlok",                   default: false
  end

  create_table "orders_users", id: false, force: true do |t|
    t.integer "order_id"
    t.integer "user_id"
  end

  create_table "products", force: true do |t|
    t.integer  "nr_roli"
    t.string   "nazwa"
    t.text     "opis"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "dane_osobowe", default: false
  end

  create_table "products_users", id: false, force: true do |t|
    t.integer "product_id"
    t.integer "user_id"
  end

  create_table "roles", force: true do |t|
    t.string   "name",        null: false
    t.string   "title",       null: false
    t.text     "description", null: false
    t.text     "the_role",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subordinates", force: true do |t|
    t.string   "imie"
    t.string   "nazwisko"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.integer  "branch_id"
    t.integer  "manager_id"
    t.string   "imie"
    t.string   "nazwisko"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
